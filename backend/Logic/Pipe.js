const getId = (function() {
    let id = 0
    return () => ++id
})()

class Pipe {

    constructor({ type, style = Pipe.PIPE_STYLE_NORMAL, special = Pipe.PIPE_SPECIAL_NORMAL, game }) {
        this.id = getId()
        this.type = type
        this.style = style
        this.special = special

        this.angle = 0
        this.water = false
        
        this.position = {x : 0, y: 0}

        this.game = game

        this.exits = []
        this._setExits()
    }

    _setExits() {
        
        if (this.style == Pipe.PIPE_STYLE_START) {
            this.exits = [
                { x: 0, y: 1 }
            ]
            return
        } else if (this.style == Pipe.PIPE_STYLE_END) {
            this.angle = 180
            this.exits = [
                { x: 0, y: -1 }
            ]
            return
        }

        if (this.type == Pipe.PIPE_VERTICAL) {
            this.exits = [
                { x: 0, y: 1 },
                { x: 0, y: -1 }
            ]

        } else if (this.type == Pipe.PIPE_CURVE) {
            this.exits = [
                { x: 0, y: -1 },
                { x: 1, y: 0 }
            ]

        } else if (this.type == Pipe.PIPE_T) {
            this.exits = [
                { x: 0, y: -1 },
                { x: 1, y: 0 },
                { x: -1, y: 0 }
            ]

        } else if (this.type == Pipe.PIPE_ALL) {
            this.exits = [
                { x: 0, y: -1 },
                { x: 0, y: 1 },
                { x: 1, y: 0 },
                { x: -1, y: 0 }
            ]
        }

    }

    rotate() {

        this.angle += 90
        this.angle = this.angle % 360
        
        this.exits = this.exits.map(exit => {
            let x = exit.x
            let y = exit.y

            if (exit.x == 1 || exit.x == -1) x = 0
            else if (exit.y == 1) x = -1
            else if (exit.y == -1) x = 1
            
            if (exit.y == 1 || exit.y == -1) y = 0
            else if (exit.x == -1) y = -1
            else if (exit.x == 1) y = 1

            return { x, y }
        })

    }

    canGrab() {
        if (this.water) return false
        if (this.style == Pipe.PIPE_STYLE_STATIC) return false
        if (this.style == Pipe.PIPE_STYLE_START) return false
        if (this.style == Pipe.PIPE_STYLE_END) return false
        return true
    }

    fullWater() {
        this.water = true
        if (this.special == Pipe.PIPE_SPECIAL_FREEZE) {
            this.game.freeze()
        }
    }

    state() {
        return {
            id: this.id,
            type: this.type,
            style: this.style,
            angle: this.angle,
            special: this.special,
            position: this.position,
            isHold: this.position === 'hold',
            water: this.water ? 1 : 0,
        }
    }

}

Pipe.PIPE_STYLE_NORMAL = "STYLE_NORMAL"
Pipe.PIPE_STYLE_OUTSIDE = "STYLE_OUTSIDE"
Pipe.PIPE_STYLE_STATIC = "STYLE_STATIC"
Pipe.PIPE_STYLE_START = "STYLE_START"
Pipe.PIPE_STYLE_END = "STYLE_END"
    
Pipe.PIPE_VERTICAL = "VERTICAL"
Pipe.PIPE_CURVE = "CURVE"
Pipe.PIPE_T = "T"
Pipe.PIPE_ALL = "ALL"

Pipe.PIPE_SPECIAL_NORMAL = "SPECIAL_NORMAL"
Pipe.PIPE_SPECIAL_FREEZE = "SPECIAL_FREEZE"

module.exports = Pipe