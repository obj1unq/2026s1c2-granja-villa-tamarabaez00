import granja.*
import wollok.game.*

class Aspersor {
    var property position
    var property id //para el on tick necesito un "id"

    method image() = "aspersor.png"

    method comenzarRiego() {
        game.onTick(1000, "riego-" + id, { self.regar() })
    }

    method regar() {
        self.cultivosCercanos().forEach({ cultivo => cultivo.regar() })
    }

    method cultivosCercanos() {
        return self.cosasCercanas().filter({ cosa => granjaVilla.esUnCultivoDeLaGranja(cosa) })
    }

    method cosasCercanas() {
        //las direcciones diagonales y ortogonales
        const posicionesVecinas = [
            position.up(1), position.up(1).right(1), position.right(1),
            position.right(1).down(1), position.down(1), position.down(1).left(1),
            position.left(1), position.left(1).up(1)
        ]
        
        const todosLosObjetos = []
        
        posicionesVecinas.forEach({ pos => 
            todosLosObjetos.addAll(game.getObjectsIn(pos)) 
        })
        
        return todosLosObjetos
    }
}

object aspersor {
    var cantidadCreados = 0 

    method colocar(personaje) {
        cantidadCreados = cantidadCreados + 1
        
        const nuevoAspersor = new Aspersor(
            position = personaje.position(), 
            id = cantidadCreados
        )
        game.addVisual(nuevoAspersor)
        nuevoAspersor.comenzarRiego()
    }
}
