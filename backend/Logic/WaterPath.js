const Pipe = require('./Pipe')

class WaterPath {

    constructor({ game, map }) {
        this.map = map
        this.game = game
        this.tiles = []
    }

    start() {
        console.log("Water start")
        const sp = this.map.startPosition
        const tile = this.map.getTileAtPosition(sp.x, sp.y)
        tile.water = true

        this.tiles = [tile]
    }

    step() {
        console.log("Water step")
        const tiles = [...this.tiles]
        for (let index = 0; index < tiles.length; index++) {
            const currentTile = tiles[index]
            
            for (let exitIndex = 0; exitIndex < currentTile.exits.length; exitIndex++) {
                const exit = currentTile.exits[exitIndex]
                
                const nextPosition = {
                    x: currentTile.position.x + exit.x,
                    y: currentTile.position.y + exit.y,
                }
                
                const nextTile = this.map.getTileAtPosition(nextPosition.x, nextPosition.y)
                if (nextTile) {
                    
                    // Check if has an entry
                    if (!this.hasEntry(currentTile, nextTile)) continue;

                    if (this.tiles.indexOf(nextTile) == -1) {
                        if (nextTile.style == Pipe.PIPE_STYLE_END) this.game.win()
                        nextTile.water = true
                        this.tiles.push(nextTile)
                    }
                }
            }
        }

        if (this.tiles.length == tiles.length) {
            this.game.lose()
        }
    }

    hasEntry(tile, checkTile) {
        for (let index = 0; index < checkTile.exits.length; index++) {
            const exit = checkTile.exits[index];
            const checkPosition = {
                x: checkTile.position.x + exit.x,
                y: checkTile.position.y + exit.y,
            }

            if (checkPosition.x == tile.position.x && checkPosition.y == tile.position.y) return true
        }
        return false
    }
}

module.exports = WaterPath