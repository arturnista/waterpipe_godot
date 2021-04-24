const getId = (function() {
    let id = 0
    return () => ++id
})()

class Player {

    constructor({ map, server }) {
        this.map = map
        this.server = server

        this.id = getId()

        this.tileHold = null
        this.position = { x: 0, y: 0 }

        this.server.sendEvent('player_register', this.state())
        this.server.on('message', (stringMessage) => {

            const message = JSON.parse(stringMessage)
            switch (message.event) {
                case 'player_input':
                    return this.processAction(message.data)
            }

        })
    }

    processAction(actions) {
        this.position = actions.position
        if (this.tileHold) {
            if (actions.select_pipe) {
                this.tileHold = this.map.placeTile(actions.position.x, actions.position.y, this.tileHold)
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
            position: this.position
        }
    }

}

module.exports = Player