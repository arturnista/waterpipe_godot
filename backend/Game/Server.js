const WebSocket = require('ws');

class Server {

    constructor() {
        
        const port = process.env.PORT || 8080
        this.webSocketServer = new WebSocket.Server({ port }, () => {
            console.log(`Game Server RUNNING!\nPort: ${port}`);
        })
        this.clients = []

        this.listeners = {}

        this.webSocketServer.on('connection', (webSocketClient) => {

            webSocketClient.sendEvent = function(event, data) {
                webSocketClient.send(JSON.stringify({ event, data }))
            }

            this._dispatchEvent('player_connect', webSocketClient)

            this.clients.push(webSocketClient)
            
        })

    }

    _dispatchEvent(event, data) {
        
        if (!this.listeners[event]) return

        const listeners = this.listeners[event]
        for (let index = 0; index < listeners.length; index++) {
            const element = listeners[index];
            element(event, data)
        }
    }

    addListener(event, handler) {
        if (!this.listeners[event]) this.listeners[event] = []
        this.listeners[event].push(handler)
    }

    removeListener(event, handler) {
        if (!this.listeners[event]) return
        this.listeners[event] = this.listeners[event].filter(x => x != handler)
    }

    broadcast(event, data) {
        this.clients.forEach(client => {
            client.send(JSON.stringify({ event, data }))
        })
    }

}

module.exports = Server