const getId = (function() {
    let id = 0
    return () => ++id
})()

class Pipe {

    constructor(type, style = Pipe.PIPE_STYLE_NORMAL) {
        this.id = getId()
        this.type = type
        this.style = style
        this.angle = 0
        this.water = false
        this.position = {x : 0, y: 0}

        this.exits = []
        this._setExits()
    }

    _setExits() {
        
        if (this.style == Pipe.PIPE_STYLE_START || this.style == Pipe.PIPE_STYLE_END) {
            this.exits = [
                { x: 0, y: 1 }
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
            
            if (exit.y == 1 || exit.y == -1) x = 0
            else if (exit.x == -1) y = -1
            else if (exit.x == 1) y = 1

            return { x, y }
        })

    }

    canGrab() {
        if (this.water) return false
        if (this.style != Pipe.PIPE_STYLE_NORMAL) return false
        return true
    }

    state() {
        return {
            id: this.id,
            type: this.type,
            style: this.style,
            angle: this.angle,
            position: this.position,
            water: this.water ? 1 : 0,
        }
    }

}

Pipe.PIPE_STYLE_NORMAL = "STYLE_NORMAL"
Pipe.PIPE_STYLE_STATIC = "STYLE_STATIC"
Pipe.PIPE_STYLE_START = "STYLE_START"
Pipe.PIPE_STYLE_END = "STYLE_END"
    
Pipe.PIPE_VERTICAL = "VERTICAL"
Pipe.PIPE_CURVE = "CURVE"
Pipe.PIPE_T = "T"
Pipe.PIPE_ALL = "ALL"

module.exports = Pipe