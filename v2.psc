Funcion ganadores<- verificarFichasRestantes(tablero)
    Definir i ,j ,blancas ,negras Como Entero
	blancas = 0
	negras = 0
	ganadores = 0
    Para i = 1 Hasta 8 con paso 1 Hacer
        Para j = 1 Hasta 8 con paso 1 hacer 
            Si tablero[i, j] = "N" o tablero[i, j] = "D" Entonces
                negras = negras + 1
            Fin Si
            Si tablero[i, j] = "B" o tablero[i, j] = "R" Entonces
                blancas = blancas + 1
            Fin Si
        Fin Para
    Fin Para
    // verificar si es cero
    Si negras = 0 Entonces
        Escribir "                                              !Felicitaciones **** Blancas ganan!!!"
		Escribir "                                                    **************************"
		pausaGeneral()
		ganadores = 1
    Fin Si
    Si blancas = 0 Entonces
        Escribir "                                              !Felicitaciones **** Negras ganan!!!"
		Escribir "                                                    **************************"
		pausaGeneral()
		ganadores = 1
    Fin Si
Fin SubProceso

subProceso moverFicha(tablero, desdeX, desdeY, hastaX, hastaY, turno, fichaEnemiga)
    Definir deltaX, deltaY Como Entero
    deltaY = hastaY - desdeY
    deltaX = hastaX - desdeX
    
    Si tablero[desdeY, desdeX] = " " Entonces
        Escribir "                                              No hay ficha en la posicion inicial"
    Sino
        Si tablero[hastaY, hastaX] <> " " Entonces
            Escribir "                                              La posicion final no esta vacia"
        Sino
            // verificar movimiento diagonal
			//abs para un numero positivo
            Si (Abs(deltaX) = Abs(deltaY)) Entonces
                // verificar si es una ficha normal
                Si (tablero[desdeY, desdeX] = "N" o tablero[desdeY, desdeX] = "B") Entonces
                    movimientosNormales(tablero, desdeX, desdeY, hastaX, hastaY, turno, deltaY, deltaX, fichaEnemiga)
                Sino
                    // movimiento para damas (R y D)
                    Si tablero[desdeY, desdeX] = "R" o tablero[desdeY, desdeX] = "D" Entonces
                        movimientosDama(tablero, desdeX, desdeY, hastaX, hastaY, deltaX, deltaY, fichaEnemiga,turno)
                    Fin Si
                Fin Si
            Sino
                Escribir "                                              Movimiento no valido"
            Fin Si
        Fin Si
    Fin Si
FinSubProceso

SubProceso movimientosDama(tablero, desdeX, desdeY, hastaX, hastaY, deltaX, deltaY, fichaEnemiga,turno)
    Definir capturarX, capturarY, i, signoX, signoY, contadorEnemigos, repetirCaptura Como Entero
    Definir movimientoValido, esCaptura Como Logico
	repetirCaptura = 0
    movimientoValido = Verdadero
    esCaptura = Falso
    contadorEnemigos = 0  // contador de fichas enemigas en el camino
    
    // determinar el signo del desplazamiento en X y Y
    Si deltaX > 0 Entonces
        signoX = 1
    Sino
        Si deltaX < 0 Entonces
            signoX = -1
        Sino
            signoX = 0
        Fin Si
    Fin Si
	
    Si deltaY > 0 Entonces
        signoY = 1
    Sino
        Si deltaY < 0 Entonces
            signoY = -1
        Sino
            signoY = 0
        Fin Si
    Fin Si
	Escribir deltaX,deltay
    // verificar que el movimiento sea diagonal
    Si Abs(deltaX) = Abs(deltaY) Entonces
        // Recorrer el camino diagonal 
        Para i = 1 Hasta Abs(deltaX) - 1 Hacer
            Si tablero[desdeY + i * signoY, desdeX + i * signoX] <> " " Entonces
                Si (tablero[desdeY + i * signoY, desdeX + i * signoX] = "N" o tablero[desdeY + i * signoY, desdeX + i * signoX] = "B" o tablero[desdeY + i * signoY, desdeX + i * signoX] = "D" o tablero[desdeY + i * signoY, desdeX + i * signoX] = "R") Entonces
                    // encontrar ficha enemiga y marcar para captura
                    contadorEnemigos = contadorEnemigos + 1
                    capturarX = desdeX + i * signoX
                    capturarY = desdeY + i * signoY
                    esCaptura = Verdadero
                Sino
                    // encontrar obstaculo no valido
                    movimientoValido = Falso
                Fin Si
            Fin Si
        Fin Para
		repetirCaptura = 0
        // verificar condiciones de captura
        Si esCaptura Entonces
            Si contadorEnemigos = 1 y movimientoValido Entonces
                Si tablero[hastaY, hastaX] = " " Entonces
                    // Verificar que la ficha a capturar sea una ficha enemiga 
                    Si tablero[capturarY, capturarX] = "N" o tablero[capturarY, capturarX] = "B" o tablero[capturarY, capturarX] = "D" o tablero[capturarY, capturarX] = "R" Entonces
                        tablero[capturarY, capturarX] = " "
                        tablero[hastaY, hastaX] = tablero[desdeY, desdeX]
                        tablero[desdeY, desdeX] = " "
						desdeX = hastaX
						desdeY = hastaY
						si turno= "N" Entonces
							Si (hastaY-2 >= 1 y hastaX-2 >= 1 y (tablero[hastaY-1, hastaX-1] = "B" o tablero[hastaY-1, hastaX-1] = "R") y tablero[hastaY-2, hastaX-2] = " " )Entonces
								Limpiar Pantalla
								mostrarTablero(tablero)
								Escribir "                                              Puede hacer captura en cadena en la posicion (",abs(hastaX-1),",",abs(hastaY-1),")"
								hastaX = hastaX - 2
								hastaY = hastaY - 2
								repetirCaptura =1
							sino 
								Si (hastaY-2 >= 1 y hastaX+2 <= 8 y (tablero[hastaY-1, hastaX+1] = "B" o tablero[hastaY-1, hastaX+1] = "R") y tablero[hastaY-2, hastaX+2] = " " )Entonces
									Limpiar Pantalla
									mostrarTablero(tablero)
									Escribir "                                              Puede hacer captura en cadena en la posicion (",abs(hastaX+1),",",abs(hastaY-1),")"
									hastaX = hastaX + 2
									hastaY = hastaY - 2
									repetirCaptura =1
								Fin Si
							Fin Si
							
							Si (hastaY+2 <= 8 y hastaX+2 <= 8 y (tablero[hastaY+1, hastaX+1] = "B" o tablero[hastaY+1, hastaX+1] = "R") y tablero[hastaY+2, hastaX+2] = " " )Entonces
								Limpiar Pantalla
								mostrarTablero(tablero)
								Escribir "                                              Puede hacer captura en cadena en la posicion (",abs(hastaX+1),",",abs(hastaY+1),")"
								hastaX = hastaX + 2
								hastaY = hastaY + 2
								repetirCaptura =1
							SiNo 
								Si( hastaY+2 <= 8 y hastaX-2 >= 1 y (tablero[hastaY+1, hastaX-1] = "B" o tablero[hastaY+1, hastaX-1] = "R")y tablero[hastaY+2, hastaX-2] = " ")Entonces
									Limpiar Pantalla
									mostrarTablero(tablero)
									Escribir "                                              Puede hacer captura en cadena en la posicion (",abs(hastaX-1),",",abs(hastaY+1),")"
									hastaX = hastaX - 2
									hastaY = hastaY + 2
									repetirCaptura =1
								Fin Si
							Fin Si
						SiNo
							Si (hastaY-2 >= 1 y hastaX-2 >= 1 y (tablero[hastaY-1, hastaX-1] = "N" o tablero[hastaY-1, hastaX-1] = "D") y tablero[hastaY-2, hastaX-2] = " " )Entonces
								Limpiar Pantalla
								mostrarTablero(tablero)
								Escribir "                                              Puede hacer captura en cadena en la posicion (",abs(hastaX-1),",",abs(hastaY-1),")"
								hastaX = hastaX - 2
								hastaY = hastaY - 2
								repetirCaptura =1
							sino 
								Si (hastaY-2 >= 1 y hastaX+2 <= 8 y (tablero[hastaY-1, hastaX+1] = "N" o tablero[hastaY-1, hastaX+1] = "D") y tablero[hastaY-2, hastaX+2] = " " )Entonces
									Limpiar Pantalla
									mostrarTablero(tablero)
									Escribir "                                              Puede hacer captura en cadena en la posicion (",abs(hastaX+1),",",abs(hastaY-1),")"
									hastaX = hastaX + 2
									hastaY = hastaY - 2
									repetirCaptura =1
								Fin Si
							Fin Si
							
							Si (hastaY+2 <= 8 y hastaX+2 <= 8 y (tablero[hastaY+1, hastaX+1] = "N" o tablero[hastaY+1, hastaX+1] = "D") y tablero[hastaY+2, hastaX+2] = " " )Entonces
								Limpiar Pantalla
								mostrarTablero(tablero)
								Escribir "                                              Puede hacer captura en cadena en la posicion (",abs(hastaX+1),",",abs(hastaY+1),")"
								hastaX = hastaX + 2
								hastaY = hastaY + 2
								repetirCaptura =1
							SiNo 
								Si( hastaY+2 <= 8 y hastaX-2 >= 1 y (tablero[hastaY+1, hastaX-1] = "N" o tablero[hastaY+1, hastaX-1] = "D")y tablero[hastaY+2, hastaX-2] = " ")Entonces
									Limpiar Pantalla
									mostrarTablero(tablero)
									Escribir "                                              Puede hacer captura en cadena en la posicion (",abs(hastaX-1),",",abs(hastaY+1),")"
									hastaX = hastaX - 2
									hastaY = hastaY + 2
									repetirCaptura =1
								Fin Si
							Fin Si	
						FinSi
						
                    Sino
                        Escribir "                                              No se puede capturar una ficha aliada o una dama propia."
                    Fin Si
                Sino
                    Escribir "                                              La casilla final no está vacía."
                Fin Si
            Sino
                Escribir "                                              Movimiento no válido, hay más de una ficha enemiga o un obstáculo en el camino."
            Fin Si
        Sino
            // movimiento simplle 
            Si tablero[hastaY, hastaX] = " " Entonces
                tablero[hastaY, hastaX] = tablero[desdeY, desdeX]
                tablero[desdeY, desdeX] = " "
            Sino
                Escribir "                                              La casilla final no está vacía."
            Fin Si
        Fin Si
    Sino
        Escribir "                                              Movimiento no válido, las damas solo se mueven en diagonal."
    Fin Si
	si repetirCaptura = 1 Entonces
		movimientosDama(tablero, desdeX, desdeY, hastaX, hastaY, hastaX - desdeX, hastaY - desdeY, fichaEnemiga,turno)
	FinSi
Fin SubProceso

SubProceso movimientosNormales(tablero, desdeX, desdeY, hastaX, hastaY, turno, deltaY, deltaX, fichaEnemiga)
    Definir capturarX, capturarY, repetirCaptura Como Entero
	repetirCaptura=0
    Si (turno = "N" y deltaY >= 0) o (turno = "B" y deltaY <= 0) Entonces
        Escribir "                                              Movimiento no valido. Las fichas solo se mueven hacia adelante."
    Sino
        // verificar si el movimiento es diagonal
        Si (Abs(deltaX) = 1 y Abs(deltaY) = 1) Entonces
            // movimiento simple sin captura
            Si tablero[hastaY, hastaX] = " " Entonces
                tablero[hastaY, hastaX] = tablero[desdeY, desdeX]
                tablero[desdeY, desdeX] = " "
            Sino
                Escribir "                                              La casilla final no esta vacía."
            Fin Si
        Sino Si (Abs(deltaX) = 2 y Abs(deltaY) = 2) Entonces
				capturarX = desdeX + (deltaX / 2)
				capturarY = desdeY + (deltaY / 2)
				Si tablero[capturarY, capturarX] = " " Entonces
					Escribir "                                              No hay ficha para capturar."
				Sino
					// verificar si es una ficha enemiga 
					Si (turno = "N" y (tablero[capturarY, capturarX] = "B" o tablero[capturarY, capturarX] = "R")) o (turno = "B" y (tablero[capturarY, capturarX] = "N" o tablero[capturarY, capturarX] = "D")) Entonces
						// realizar la captura
						tablero[capturarY, capturarX] = " "
						tablero[hastaY, hastaX] = tablero[desdeY, desdeX]
						tablero[desdeY, desdeX] = " "
						// intentar captura en cadena
						desdeX = hastaX
						desdeY = hastaY
						Si turno = "N" Entonces
							Si (hastaY-2 >= 1 y hastaX-2 >= 1 y (tablero[hastaY-1, hastaX-1] = "B" o tablero[hastaY-1, hastaX-1] = "R" )y tablero[hastaY-2, hastaX-2] = " " )Entonces
								Limpiar Pantalla
									mostrarTablero(tablero)
									Escribir "                                              Puede hacer captura en cadena en la posicion (",abs(hastaX-1),",",abs(hastaY-1),")"
									hastaX = hastaX - 2
									hastaY = hastaY - 2
									repetirCaptura =1
								SiNo 
									Si (hastaY-2 >= 1 y hastaX+2 <= 8 y (tablero[hastaY-1, hastaX+1] = "B" o tablero[hastaY-1, hastaX+1] = "R") y tablero[hastaY-2, hastaX+2] = " " )Entonces
										Limpiar Pantalla
										mostrarTablero(tablero)
										Escribir "                                              Puede hacer captura en cadena en la posicion (",abs(hastaX+1),",",abs(hastaY-1),")"
										hastaX = hastaX + 2
										hastaY = hastaY - 2
										repetirCaptura =1
									Fin Si
								Fin Si
							Sino
								Si (hastaY+2 <= 8 y hastaX+2 <= 8 y (tablero[hastaY+1, hastaX+1] = "N" o tablero[hastaY+1, hastaX+1] = "D") y tablero[hastaY+2, hastaX+2] = " " )Entonces
									Limpiar Pantalla
									mostrarTablero(tablero)
									Escribir "                                              Puede hacer captura en cadena en la posicion (",abs(hastaX+1),",",abs(hastaY+1),")"
									hastaX = hastaX + 2
									hastaY = hastaY + 2
									repetirCaptura =1
								SiNo 
									Si( hastaY+2 <= 8 y hastaX-2 >= 1 y (tablero[hastaY+1, hastaX-1] = "N" o tablero[hastaY+1, hastaX-1] = "D")y tablero[hastaY+2, hastaX-2] = " ")Entonces
										Limpiar Pantalla
										mostrarTablero(tablero)
										Escribir "                                              Puede hacer captura en cadena en la posicion (",abs(hastaX-1),",",abs(hastaY+1),")"
										hastaX = hastaX - 2
										hastaY = hastaY + 2
										repetirCaptura =1
										
									Fin Si
								Fin Si
							Fin Si
					Sino
						Escribir "                                              Solo puedes capturar fichas del oponente."
					Fin Si
				Fin Si
			Sino
				Escribir "                                              Movimiento no válido. Solo puedes moverte un espacio diagonal o capturar."
			Fin Si
		Fin Si
	FinSi
	si repetirCaptura = 1 Entonces
		movimientosNormales(tablero, desdeX, desdeY, hastaX, hastaY, turno, hastaY - desdeY, hastaX - desdeX, fichaEnemiga)
	FinSi
	// dama
	Si turno = "N" y hastaY = 1 Entonces
		tablero[hastaY, hastaX] = "D"
	Fin Si
	Si turno = "B" y hastaY = 8 Entonces
		tablero[hastaY, hastaX] = "R"
	Fin Si	
Fin SubProceso

SubProceso inicioJuego(ganador, turno, tablero, desdeX, desdeY, hastaX, hastaY, turno, fichaEnemiga)
	definir sinicialX, sinicialY,inicialX, inicialY, finalX, finalY, sfinalX, sfinalY,obligatorio Como Entero
	inicialX <- 0
    inicialY <- 0
	sinicialX <- 0
    sinicialY <- 0
    sfinalX <- 0
    sfinalY <- 0
	finalX <- 0
    finalY <- 0
	obligatorio <- 0
	Escribir "                                              Es el turno de las fichas ", turno
    Para i = 1 Hasta 8 con paso 1 hacer
        Para j = 1 Hasta 8 con paso 1 hacer
            // verificar si la celda es válida para jugar
            Si (i + j) % 2 = 1 Entonces
                // Capturas para fichas blancas
                Si turno = "N" y (tablero[i, j] = "N")  Entonces
                    // validar captura hacia arriba-izquierda
                    Si i >= 3 y j >= 3 Entonces
                        Si tablero[i-2, j-2] = " " y (tablero[i-1, j-1] = "B" o tablero[i-1, j-1] = "R") Entonces
							si obligatorio = 0 Entonces
								inicialX <- j
								inicialY <- i
								finalX <- j-2
								finalY <- i-2
								Escribir "                                              Captura Obligatoria: Inicial (", inicialX, ",", inicialY, ") a Final (", finalX, ",", finalY, ")"
								obligatorio <- 1
							sino
								sinicialX <- j
								sinicialY <- i
								sfinalX <- j-2
								sfinalY <- i-2
								Escribir "                                              Captura Obligatoria: Inicial (", sinicialX, ",", sinicialY, ") a Final (", sfinalX, ",", sfinalY, ")"
							FinSi
                        Fin Si
                    Fin Si
                    // validar captura hacia arriba-derecha
                    Si i >= 3 y j <= 6 Entonces
                        Si tablero[i-2, j+2] = " " y (tablero[i-1, j+1] = "B" o tablero[i-1, j+1] = "R") Entonces
							si obligatorio = 0 Entonces
								inicialX <- j
								inicialY <- i
								finalX <- j+2
								finalY <- i-2
								Escribir "                                              Captura Obligatoria: Inicial (", inicialX, ",", inicialY, ") a Final (", finalX, ",", finalY, ")"
								obligatorio <- 1
							SiNo
								sinicialX <- j
								sinicialY <- i
								sfinalX <- j+2
								sfinalY <- i-2
								Escribir "                                              Captura Obligatoria: Inicial (", sinicialX, ",", sinicialY, ") a Final (", sfinalX, ",", sfinalY, ")"
							FinSi	
                        Fin Si
                    FinSi
				SiNo
					si turno = "N" y (tablero[i, j] = "D" )  Entonces
						Si i >= 3 y j >= 3 Entonces
							Si tablero[i-2, j-2] = " " y (tablero[i-1, j-1] = "B" o tablero[i-1, j-1] = "R") Entonces
								si obligatorio = 0 Entonces
									inicialX <- j
									inicialY <- i
									finalX <- j-2
									finalY <- i-2
									Escribir "                                              Captura Obligatoria: Inicial (", inicialX, ",", inicialY, ") a Final (", finalX, ",", finalY, ")"
									obligatorio <- 1
								sino
									sinicialX <- j
									sinicialY <- i
									sfinalX <- j-2
									sfinalY <- i-2
									Escribir "                                              Captura Obligatoria: Inicial (", sinicialX, ",", sinicialY, ") a Final (", sfinalX, ",", sfinalY, ")"
								FinSi
							Fin Si
						Fin Si
						Si i >= 3 y j <= 6 Entonces
							Si tablero[i-2, j+2] = " " y (tablero[i-1, j+1] = "B" o tablero[i-1, j+1] = "R") Entonces
								si obligatorio = 0 Entonces
									inicialX <- j
									inicialY <- i
									finalX <- j+2
									finalY <- i-2
									Escribir "                                              Captura Obligatoria: Inicial (", inicialX, ",", inicialY, ") a Final (", finalX, ",", finalY, ")"
									obligatorio <- 1
								SiNo
									sinicialX <- j
									sinicialY <- i
									sfinalX <- j+2
									sfinalY <- i-2
									Escribir "                                              Captura Obligatoria: Inicial (", sinicialX, ",", sinicialY, ") a Final (", sfinalX, ",", sfinalY, ")"
								FinSi
							Fin Si
						Fin Si
						Si i <= 6 y j <= 6 Entonces
							Si tablero[i+2, j+2] = " " y (tablero[i+1, j+1] = "B" o tablero[i+1, j+1] = "R")Entonces
								si obligatorio = 0 Entonces
									inicialX <- j
									inicialY <- i
									finalX <- j+2
									finalY <- i+2
									Escribir "                                              Captura Obligatoria: Inicial (", inicialX, ",", inicialY, ") a Final (", finalX, ",", finalY, ")"
									obligatorio <- 1
								SiNo
									sinicialX <- j
									sinicialY <- i
									sfinalX <- j+2
									sfinalY <- i+2
									Escribir "                                              Captura Obligatoria: Inicial (", sinicialX, ",", sinicialY, ") a Final (", sfinalX, ",", sfinalY, ")"
								FinSi
							Fin Si
						Fin Si
						Si i <= 6 y j >= 3 Entonces
							Si tablero[i+2, j-2] = " " y (tablero[i+1, j-1] = "B" o tablero[i+1, j-1] = "R")Entonces
								si obligatorio = 0 Entonces
									inicialX <- j
									inicialY <- i
									finalX <- j-2
									finalY <- i+2
									Escribir "                                              Captura Obligatoria: Inicial (", inicialX, ",", inicialY, ") a Final (", finalX, ",", finalY, ")"
									obligatorio <- 1
								SiNo
									sinicialX <- j
									sinicialY <- i
									sfinalX <- j-2
									sfinalY <- i+2
									Escribir "                                              Captura Obligatoria: Inicial (", sinicialX, ",", sinicialY, ") a Final (", sfinalX, ",", sfinalY, ")"
								FinSi
							Fin Si
						Fin Si
					FinSi
                Fin Si
                // capturas para fichas negras
                Si turno = "B" y (tablero[i, j] = "B" )  Entonces	
                    // validar captura hacia abajo-izquierda
                    Si i <= 6 y j >= 3 Entonces
                        Si tablero[i+2, j-2] = " " y (tablero[i+1, j-1] = "N" o tablero[i+1, j-1] = "D")Entonces
							si obligatorio = 0 Entonces
								inicialX <- j
								inicialY <- i
								finalX <- j-2
								finalY <- i+2
								Escribir "                                              Captura Obligatoria: Inicial (", inicialX, ",", inicialY, ") a Final (", finalX, ",", finalY, ")"
								obligatorio <- 1
							SiNo
								sinicialX <- j
								sinicialY <- i
								sfinalX <- j-2
								sfinalY <- i+2
								Escribir "                                              Captura Obligatoria: Inicial (", sinicialX, ",", sinicialY, ") a Final (", sfinalX, ",", sfinalY, ")"
							FinSi
							
                        Fin Si
                    Fin Si
                    // validar captura hacia abajo-derecha
                    Si i <= 6 y j <= 6 Entonces
                        Si tablero[i+2, j+2] = " " y (tablero[i+1, j+1] = "N" o tablero[i+1, j+1] = "D")Entonces
							si obligatorio = 0 Entonces
								inicialX <- j
								inicialY <- i
								finalX <- j+2
								finalY <- i+2
								Escribir "                                              Captura Obligatoria: Inicial (", inicialX, ",", inicialY, ") a Final (", finalX, ",", finalY, ")"
								obligatorio <- 1
							SiNo
								sinicialX <- j
								sinicialY <- i
								sfinalX <- j+2
								sfinalY <- i+2
								Escribir "                                              Captura Obligatoria: Inicial (", sinicialX, ",", sinicialY, ") a Final (", sfinalX, ",", sfinalY, ")"
							FinSi
                        Fin Si
                    Fin Si
				SiNo
					Si turno = "B" y (tablero[i, j] = "R" )  Entonces	
						Si i <= 6 y j >= 3 Entonces
							Si tablero[i+2, j-2] = " " y (tablero[i+1, j-1] = "N" o tablero[i+1, j-1] = "D")Entonces
								si obligatorio = 0 Entonces
									inicialX <- j
									inicialY <- i
									finalX <- j-2
									finalY <- i+2
									Escribir "                                              Captura Obligatoria: Inicial (", inicialX, ",", inicialY, ") a Final (", finalX, ",", finalY, ")"
									obligatorio <- 1
								SiNo
									sinicialX <- j
									sinicialY <- i
									sfinalX <- j-2
									sfinalY <- i+2
									Escribir "                                              Captura Obligatoria: Inicial (", sinicialX, ",", sinicialY, ") a Final (", sfinalX, ",", sfinalY, ")"
								FinSi
								
							Fin Si
						Fin Si
						Si i <= 6 y j <= 6 Entonces
							Si tablero[i+2, j+2] = " " y (tablero[i+1, j+1] = "N" o tablero[i+1, j+1] = "D")Entonces
								si obligatorio = 0 Entonces
									inicialX <- j
									inicialY <- i
									finalX <- j+2
									finalY <- i+2
									Escribir "                                              Captura Obligatoria: Inicial (", inicialX, ",", inicialY, ") a Final (", finalX, ",", finalY, ")"
									obligatorio <- 1
								SiNo
									sinicialX <- j
									sinicialY <- i
									sfinalX <- j+2
									sfinalY <- i+2
									Escribir "                                              Captura Obligatoria: Inicial (", sinicialX, ",", sinicialY, ") a Final (", sfinalX, ",", sfinalY, ")"
								FinSi
							Fin Si
						Fin Si
						Si i >= 3 y j >= 3 Entonces
							Si ((tablero[i-2, j-2] = " " ) y (tablero[i-1, j-1] = "N" o tablero[i-1, j-1] = "D")) Entonces
								si obligatorio = 0 Entonces
									inicialX <- j
									inicialY <- i
									finalX <- j-2
									finalY <- i-2
									Escribir "                                              Captura Obligatoria: Inicial (", inicialX, ",", inicialY, ") a Final (", finalX, ",", finalY, ")"
									obligatorio <- 1
								sino
									sinicialX <- j
									sinicialY <- i
									sfinalX <- j-2
									sfinalY <- i-2
									Escribir "                                              Captura Obligatoria: Inicial (", sinicialX, ",", sinicialY, ") a Final (", sfinalX, ",", sfinalY, ")"
								FinSi
							Fin Si
						Fin Si
						Si i >= 3 y j <= 6 Entonces
							Si(tablero[i-2, j+2] = " "  y (tablero[i-1, j+1] = "N" o tablero[i-1, j+1] = "D")) Entonces
								si obligatorio = 0 Entonces
									inicialX <- j
									inicialY <- i
									finalX <- j+2
									finalY <- i-2
									Escribir "                                              Captura Obligatoria: Inicial (", inicialX, ",", inicialY, ") a Final (", finalX, ",", finalY, ")"
									obligatorio <- 1
								SiNo
									sinicialX <- j
									sinicialY <- i
									sfinalX <- j+2
									sfinalY <- i-2
									Escribir "                                              Captura Obligatoria: Inicial (", sinicialX, ",", sinicialY, ") a Final (", sfinalX, ",", sfinalY, ")"
								FinSi
								
							Fin Si
						Fin Si
					FinSi
                Fin Si
            Fin Si
        Fin Para
    Fin Para	
	
	Si ganador <> 1 Entonces
		si obligatorio = 1 Entonces
			Escribir "                                              Hay una captura obligatoria."
		FinSi
		Repetir
			flag = 0
			Escribir "                                              Introduce la posición inicial (x y): "
			Leer desdeX, desdeY
			Si desdeX < 1 o desdeX > 8 o desdeY < 1 o desdeY > 8 Entonces
				Escribir "                                              Coordenadas iniciales fuera del rango. Deben estar entre 1 y 8."
			Sino
				si obligatorio = 1 Entonces
					Si ((inicialX = desdeX y inicialY = desdeY) o (sinicialX = desdeX y sinicialY = desdeY)) Entonces
						flag = 1
					SiNo
						Escribir "                                              Debes seleccionar las coordenadas sugeridas: Inicial (", inicialX, ",", inicialY, ")."
						si sinicialX <> 0 Entonces
							Escribir "                                              Debes seleccionar las coordenadas sugeridas: Inicial (", sinicialX, ",", sinicialY, ")."
						FinSi
					Fin Si
				SiNo
					flag =1
				FinSi
			Fin Si
		Hasta Que flag = 1
		Repetir
			flag = 0
			Escribir "                                              Introduce la posición final (x y): "
			Leer hastaX, hastaY
			Si hastaX < 1 o hastaX > 8 o hastaY < 1 o hastaY > 8 Entonces
				Escribir "                                              Coordenadas finales fuera del rango. Deben estar entre 1 y 8."
			Sino
				si obligatorio = 1 Entonces
					Si (((desdeX = inicialX Y desdeY = inicialY) Y (finalX = hastaX Y finalY = hastaY)) o ((desdeX = sinicialX Y desdeY = sinicialY) Y (sfinalX = hastaX Y sfinalY = hastaY))) Entonces
						flag = 1
					SiNo 
						si (desdeX = inicialX Y desdeY = inicialY) Entonces
							Escribir "                                              Debes seleccionar las coordenadas sugeridas: Final (", finalX, ",", finalY, ")."
						SiNo
							Escribir "                                              Debes seleccionar las coordenadas sugeridas: Final (", sfinalX, ",", sfinalY, ")."
						FinSi
					Fin Si
				SiNo
					flag =1
				FinSi
			Fin Si
		Hasta Que flag = 1 
		moverFicha(tablero, desdeX, desdeY, hastaX, hastaY, turno, fichaEnemiga)
	FinSi
FinSubProceso

SubProceso mostrarTablero(tablero)
    Escribir "                                                  1   2   3   4   5   6   7   8"
    Escribir "                                                +---+---+---+---+---+---+---+---+"
    Para i = 1 Hasta 8 Hacer
        Escribir Sin Saltar "                                             ",i, "  |"
        Para j = 1 Hasta 8 hacer
            Escribir Sin Saltar " ", tablero[i, j], " |"
        FinPara
        Escribir "                                         " 
        Escribir "                                                +---+---+---+---+---+---+---+---+"
    FinPara
FinSubProceso

SubProceso cargarTablero(tablero)
    Para i = 1 Hasta 8 con paso 1 hacer
        Para j = 1 Hasta 8 con paso 1 hacer
            Si (i + j) % 2 = 0 Entonces
                tablero[i,j] = " " 
            Sino
                Si i <= 3 Entonces
                    tablero[i,j] = "B" 
                Sino
                    Si i >= 6 Entonces
                        tablero[i,j] = "N" 
                    Sino
                        tablero[i,j] = " " 
                    Fin Si
                Fin Si
            Fin Si
        FinPara
    FinPara
FinSubProceso

SubProceso pausaGeneral
	Escribir "                                              Presione cualquier tecla para continuar...."
    Esperar Tecla
FinSubProceso

SubProceso mostrarMenu(opc)
    Escribir "                                              +--------------------------------------------+"
    Escribir "                                              |                   MENU                     |"
    Escribir "                                              +--------------------------------------------+"
    Escribir "                                              | 1. Jugar                                   |"
    Escribir "                                              | 2. Instrucciones                           |"
    Escribir "                                              | 3. Salir                                   |"
    Escribir "                                              +--------------------------------------------+"
    Escribir "                                              Selecciona una opcion: "
FinSubProceso

SubProceso mostrarInstrucciones
	Limpiar Pantalla
    Escribir "                                              +----------------------------------------------------------------------+"
    Escribir "                                              |   ___ _   _ ____ _____ ____  _   _  ____ ___ ___  _   _ _____ ____   |"
	Escribir "                                              |  |_ _| \ | / ___|_   _|  _ \| | | |/ ___|_ _/ _ \| \ | | ____/ ___|  |"
	Escribir "                                              |   | ||  \| \___ \ | | | |_) | | | | |    | | | | |  \| |  _| \___ \  |"
	Escribir "                                              |   | || |\  |___) || | |  _ <| |_| | |___ | | |_| | |\  | |___ ___) | |"
	Escribir "                                              |  |___|_| \_|____/ |_| |_| \_\\___/ \____|___\___/|_| \_|_____|____/  |"
    Escribir "                                              +----------------------------------------------------------------------+"
    Escribir "                                              | 1. El objetivo es capturar todas las fichas del oponente o           |"
    Escribir "                                              |    bloquear su movimiento.                                           |"
    Escribir "                                              | 2. Las fichas se mueven en diagonal.                                 |"
    Escribir "                                              | 3. Al llegar al final del tablero, una ficha se convierte en dama.   |"
    Escribir "                                              +----------------------------------------------------------------------+"
	Escribir "                                              Presiona Enter para regresar al menu."
    Esperar Tecla
FinSubProceso

SubProceso inicio
	Escribir "                                              +-------------------------------------------+"
    Escribir "                                              |                                           |"
    Escribir "                                              |                                           |"
    Escribir "                                              |                                           |"
    Escribir "                                              |     ____    _    __  __    _    ____      |"
    Escribir "                                              |    |  _ \  / \  |  \/  |  / \  / ___|     |"
    Escribir "                                              |    | | | |/ _ \ | |\/| | / _ \ \___ \     |"
    Escribir "                                              |    | |_| / ___ \| |  | |/ ___ \ ___) |    |"
    Escribir "                                              |    |____/_/   \_\_|  |_/_/   \_\____/     |"
    Escribir "                                              |                                           |"
    Escribir "                                              |                                           |"
    Escribir "                                              |                                           |"
    Escribir "                                              +-------------------------------------------+"
	pausaGeneral()
FinSubProceso

Algoritmo damas
    Definir tablero, turno Como Caracter
    Definir desdeX, desdeY, hastaX, hastaY, opc, flag, ganador, fichaEnemiga Como Entero
    Dimension tablero[8, 8] 
    inicio()
    Repetir
        Limpiar Pantalla
        mostrarMenu(opc)
        Leer opc 
        Si opc = 1 Entonces
			turno = "N"
			cargarTablero(tablero)
			fichaEnemiga = 0
            Repetir
                pausaGeneral()
                Limpiar Pantalla
                mostrarTablero(tablero)
				ganador = verificarFichasRestantes(tablero)
				//si ganador es 1 termino el repetir
				si ganador <> 1 Entonces
					inicioJuego(ganador, turno,tablero, desdeX, desdeY, hastaX, hastaY, turno, fichaEnemiga)
					
					Si turno = "N" Entonces
						turno = "B"
					Sino
						turno = "N"
					FinSi
				FinSi
            Hasta Que ganador = 1
        SiNo
            Si opc = 2 Entonces
                mostrarInstrucciones()
            Fin Si
        Fin Si
    Hasta Que opc = 3
    Limpiar Pantalla
    Escribir "                                              Saliendo del juego..."
FinAlgoritmo