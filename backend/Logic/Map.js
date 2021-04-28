const Pipe = require('./Pipe')

class Map {

    constructor(size) {
        this.size = size
        this.tiles = {}
        this.startPosition = {}
        this.endPosition = {}
    }

    _verifyPosition(x, y) {
        if (x < 0 || y < 0) return false
        if (x >= this.size || y >= this.size) return false
        return true
    }

    randomize() {

        this.startPosition = {
            x: Math.floor(Math.random() * this.size),
            y: 0
        }

        this.endPosition = {
            x: Math.floor(Math.random() * this.size),
            y: this.size - 1
        }

        const xDiff = Math.abs(this.endPosition.x - this.startPosition.x)
        const yDiff = Math.abs(this.endPosition.y - this.startPosition.y) - xDiff

        const preTiles = []
        for (let index = 0; index < xDiff; index++) {
            preTiles.push(new Pipe(Pipe.PIPE_CURVE))
        }
        for (let index = 0; index < yDiff; index++) {
            preTiles.push(new Pipe(Pipe.PIPE_VERTICAL))
        }

        // Map size - pre tiles - start and end
        const mapSize = Math.pow(this.size, 2) - preTiles.length - 2
        for (let index = 0; index < mapSize; index++) {
            const rand = Math.round(Math.random() * 10)
            let pipeType = Pipe.PIPE_VERTICAL
            if (rand == 0) pipeType = Pipe.PIPE_T
            if (rand == 1) pipeType = Pipe.PIPE_ALL
            preTiles.push(new Pipe(pipeType))            
        }

        for (let x = 0; x < this.size; x++) {
            for (let y = 0; y < this.size; y++) {
                let tile = null
                if (x == this.startPosition.x && y == this.startPosition.y) {
                    tile = new Pipe(Pipe.PIPE_VERTICAL, Pipe.PIPE_STYLE_START)
                } else if (x == this.endPosition.x && y == this.endPosition.y) {
                    tile = new Pipe(Pipe.PIPE_VERTICAL, Pipe.PIPE_STYLE_END)
                } else {
                    tile = preTiles.pop()
                }
                this.createTile(x, y, tile)
            }
        }

    }

    createTile(x, y, tile) {
        if (!this._verifyPosition(x, y)) return null
        if (tile.style == Pipe.PIPE_STYLE_NORMAL) {
            const rand = Math.round(Math.random() * 2)
            for (let index = 0; index < rand; index++) {
                tile.rotate()
            }
        }
        tile.position = { x, y }
        this.tiles[tile.id] = tile
    }

    getTileAtPosition(x, y) {
        if (!this._verifyPosition(x, y)) return null
        for (const key in this.tiles) {
            const element = this.tiles[key]
            if (element.position != 'hold' && element.position.x == x && element.position.y == y) {
                return element
            }
        }

        return null
    }

    placeTile(x, y, tile) {
        if (!this._verifyPosition(x, y)) return null

        let positionTile = this.getTileAtPosition(x, y)

        this.tiles[tile.id].position = { x, y }

        if (positionTile) {
            this.tiles[positionTile.id].position = 'hold'
        }

        return positionTile ? positionTile : null
    }

    grabTile(x, y) {
        if (!this._verifyPosition(x, y)) return null
        
        let positionTile = this.getTileAtPosition(x, y)
        if (positionTile == null) return null
        if (!positionTile.canGrab()) return null

        this.tiles[positionTile.id].position = 'hold'
        return this.tiles[positionTile.id]
    }

    state() {
        return {
            size: this.size,
            tiles: Object.keys(this.tiles).map(key => this.tiles[key].state())
        }
    }
}

module.exports = Map