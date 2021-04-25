const Server = require("./Server")
const Game = require("../Logic/Game")

const getId = (function() {
    let id = 0
    return () => ++id
})()

const FPS = 60
const TICK_LENGTH_MS = 1000 / FPS

class Engine {

    constructor({ FPS, port }) {
        this.id = getId()
        
        this.TICK_LENGTH_MS = 1000 / FPS
        this.server = new Server({ port })
        this.createGame()

        this.handlePlayerConnect = this.handlePlayerConnect.bind(this)
        this.server.addListener('player_connect', this.handlePlayerConnect)
    }

    handlePlayerConnect(event, message) {
        this.game.onPlayerConnect(event, message)
    }

    createGame() {
        console.log("ENGINE | Game created")
        
        this.game = new Game({
            engine: this,
            server: this.server,
        })

        this.startGame()
    }

    startGame() {

        this.previousTick = Date.now()
        this.game.start()
        
        this.gameIsRunning = true
        this.gameLoop()
        
    }
    
    gameLoop() {

        if(!this.gameIsRunning) return

        const now = Date.now()

        if (this.previousTick + this.TICK_LENGTH_MS <= now) {
            const delta = (now - this.previousTick) / 1000
            this.previousTick = now

            this.game.frame(delta)
            this.server.broadcast('gameState', this.game.state())
        }

        if (Date.now() - this.previousTick < this.TICK_LENGTH_MS - 16) {
            setTimeout(this.gameLoop.bind(this))
        } else {
            setImmediate(this.gameLoop.bind(this))
        }
        
    }

}

module.exports = Engine