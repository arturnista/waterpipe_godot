const Map = require('./Map')
const Player = require('./Player')

class Engine {

    constructor(server) {
        this.server = server
        this.map = new Map(10)
        this.time = 0
        this.players = []

     
        this.handlePlayerConnect = this.handlePlayerConnect.bind(this)
    }

    start() {
        this.server.addListener('player_connect', this.handlePlayerConnect)
        this.map.randomize()
    }

    frame(deltatime) {
        this.time += deltatime
        if (this.time > 1) {
            this.time = 0
        }
    }

    handlePlayerConnect(event, message) {
        this.players.push(
            new Player({
                map: this.map,
                server: message,
            })
        )
    }

    gameState() {
        return {
            map: this.map.state(),
            players: this.players.map(x => x.state())
        }
    }

}

module.exports = Engine