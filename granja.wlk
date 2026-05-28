import personaje.*
import cultivos.*
import wollok.game.*
import mercado.*

object granjaVilla {
    const property cultivosCosechados= []
    const cultivosSembrados= []
    var valorEnOro= 0

    method guardarCosecha(cultivo){
        cultivosSembrados.remove(cultivo)
        cultivosCosechados.add(cultivo)
    }

    method cultivosEn(posicion) {
        return cultivosSembrados.filter({ cultivo => cultivo.position() == posicion })
    }

    method hayCultivoEn(posicion) {
        return cultivosSembrados.any({ cultivo => cultivo.position() == posicion })
    }

    method registrarSiembra(cultivo) {
        cultivosSembrados.add(cultivo)
    }

    method valorDeCultivoEnOro() = cultivosCosechados.sum( {cultivo => cultivo.precio()} )

    method venderCultivosCosechados() {
      cultivosCosechados.clear()
    }

    method cantidadCultivosCosechados() = cultivosCosechados.size()

    method esUnCultivoDeLaGranja(cosa) {
        return cultivosSembrados.contains(cosa)
    }
}
