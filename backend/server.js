const http = require('http');
const WebSocket = require('ws');
const url = require('url');
const Engine = require('./Engine')

const handles = {
    'POST': {
        '/createRoom': function(request) {
            const engineData = createEngine()
            return engineData
        }
    }
}

const server = http.createServer(function(request, response) {
    const method = handles[request.method]
    if (!method) {
        response.writeHead(500, {'Content-Type': 'application/json'})
        response.end(JSON.stringify({ error: 'wrong method' }))
        return
    }

    const func = method[request.url]
    if (!func) {
        response.writeHead(500, {'Content-Type': 'application/json'})
        response.end(JSON.stringify({ error: 'wrong function' }))
        return
    }

    try {
        const result = func(request, response)
        response.writeHead(200, {'Content-Type': 'application/json'})
        response.end(JSON.stringify(result))
    } catch (error) {
        response.writeHead(500, {'Content-Type': 'application/json'})
        response.end(JSON.stringify({ error }))
    }
});

server.on('upgrade', function upgrade(request, socket, head) {
    const gameEngine = gameEngines.find(x => `/${x.name}` === request.url)
    if (gameEngine) {
        gameEngine.socket.handleUpgrade(request, socket, head, function done(ws) {
            gameEngine.socket.emit('connection', ws, request);
        });
    } else {
        socket.destroy();
    }
});

const gameEngines = []
// createEngine()
// createEngine({ name: 'engine2' })

function createEngine() {
    const engine = new Engine({ FPS: 10 })
    const engineData = {
        id: engine.id,
        name: engine.name,
        socket: engine.getServer().getSocket()
    }
    gameEngines.push(engineData)
    return {
        name: engineData.name,
    }
}

const port = process.env.PORT || 3000
server.listen(port, () => {
    console.log(`Master server running on port ${port}`)
});