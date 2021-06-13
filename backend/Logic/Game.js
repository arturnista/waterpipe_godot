const Map = require('./Map')
const WaterPath = require('./WaterPath')
const Player = require('./Player')

const WATER_STEP_START_TIME = 10
const WATER_STEP_TIME = 5

class Game {

    constructor({ engine, server }) {
        this.engine = engine
        this.server = server
        this.map = new Map(10)

        this.waterPath = new WaterPath({ map: this.map, game: this })
        this.waterTime = 0
        this.waterStarted = false
        this.players = []

        this.WATER_STEP_TIME = WATER_STEP_TIME
    }

    start() {
        this.changeGameState('WAITING')
    }

    startGame() {
        this.map.randomize()
        this.server.broadcast('game-start', {})
        this.changeGameState('GAME')
    }

    changeGameState(state) {
        this.gameState = state
        this.engine.log(`GAME | Game state changed to ${this.gameState}`)
    }

    frame(deltatime) {
        if (this.gameState != 'GAME') return

        this.waterTime += deltatime
        if (!this.waterStarted) {
            if (this.waterTime > WATER_STEP_START_TIME) {
                this.waterTime = 0
                this.waterPath.start()
                this.waterStarted = true
            }
        } else {
            if (this.waterTime > this.WATER_STEP_TIME) {
                this.waterTime = 0
                this.waterPath.step()
            }
        }
    }

    onPlayerConnect(event, message) {
        
        const player = new Player({
            map: this.map,
            game: this,
            server: message,
            leader: this.players.length == 0
        })
        this.players.push(player)

        this.engine.log(`GAME | Player connected ${player.leader ? "LEADER!" : ''}`)
    }

    onPlayerDisconnect(player) {
        this.players = this.players.filter(x => x.id !== player.id)
        if (this.players.length == 0) {
            this.engine.createGame()
        } else if (player.leader) {
            this.players[0].leader = true
        }
    }
    
    fast() {
        this.WATER_STEP_TIME /= 2
    }

    state() {
        return {
            map: this.map.state(),
            players: this.players.map(x => x.state()),
            state: this.gameState
        }
    }

    win() {
        this.changeGameState('WIN')
        this.server.broadcast('game-win', {})
    }

    lose() {
        this.changeGameState('LOSE')
        this.server.broadcast('game-lose', {})
    }

}

module.exports = Game