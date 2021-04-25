// const express = require('express')
// const app = express()
 
// const games = []
// const port = process.env.PORT || 3000

// app.post('/server', function (req, res) {
//     const Engine = require('./Engine')
//     const engine = new Engine({ FPS: 10, port })

//     games.push(engine)

//     res.status(200).json({
//         id: engine.id,
//         port
//     })
// })

// app.listen(port, () => {
//     console.log('ENGINE SERVER RUNNING')
//     console.log(`Port: ${port}`)
    
// })


const Engine = require('./Engine')
const port = process.env.PORT || 3000
const engine = new Engine({ FPS: 10, port })