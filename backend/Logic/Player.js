const getId = (function() {
    let id = 0
    return () => ++id
})()

class Player {

    constructor({ map, server, game, leader }) {
        this.map = map
        this.server = server
        this.game = game

        this.id = getId()
        this.leader = leader

        this.tileHold = null
        this.position = { x: 0, y: 0 }

        this.server.sendEvent('player_register', this.state())
        this.server.on('message', (stringMessage) => {

            const message = JSON.parse(stringMessage)
            switch (message.event) {
                case 'player_leader_start_game':
                    if (!this.leader) return
                    this.game.startGame()
                case 'player_leader_fast':
                    if (!this.leader) return
                    this.game.fast()
                case 'player_input':
                    return this.processAction(message.data)
            }

        })
        this.server.on('close', () => {
            this.game.onPlayerDisconnect(this)
        })
    }

    processAction(actions) {
        this.position = actions.position
        if (this.tileHold) {
            if (actions.select_pipe) {
                let lastTile = this.tileHold
                this.tileHold = this.map.placeTile(actions.position.x, actions.position.y, this.tileHold)
                if (this.tileHold && this.tileHold.id == lastTile.id) {
                    this.server.sendEvent('player_place_error', this.state())
                }
            }
            
            if (actions.rotate_pipe) {
                this.tileHold.rotate()
            }
        } else {
            if (actions.select_pipe) {
                this.tileHold = this.map.grabTile(actions.position.x, actions.position.y)
            }
        }
        
    }

    state() {
        return {
            id: this.id,
            tileHold: this.tileHold ? this.tileHold.id : -1,
            position: this.position,
            leader: this.leader,
        }
    }

}

module.exports = Player