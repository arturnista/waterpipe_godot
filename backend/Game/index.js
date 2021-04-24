const Server = require("./Server")
const Engine = require("../Logic/Engine")

const FPS = 60
const TICK_LENGTH_MS = 1000 / FPS

class Game {

    constructor(FPS = 60) {
        this.TICK_LENGTH_MS = 1000 / FPS
        this.server = new Server()
        this.engine = new Engine(this.server)

        this.startGame()
    }

    startGame() {

        this.previousTick = Date.now()
        this.engine.start()
        
        this.gameIsRunning = true
        this.gameLoop()
        
    }
    
    gameLoop() {

        if(!this.gameIsRunning) return

        const now = Date.now()

        if (this.previousTick + this.TICK_LENGTH_MS <= now) {
            const delta = (now - this.previousTick) / 1000
            this.previousTick = now

            this.engine.frame(delta)
            this.server.broadcast('gameState', this.engine.gameState())
        }

        if (Date.now() - this.previousTick < this.TICK_LENGTH_MS - 16) {
            setTimeout(this.gameLoop.bind(this))
        } else {
            setImmediate(this.gameLoop.bind(this))
        }
        
    }

}

module.exports = Game