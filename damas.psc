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
        Escribir "                                              ¡Felicitaciones **** Blancas ganan!!!"
		pausaGeneral()
		ganadores = 1
    Fin Si
    Si blancas = 0 Entonces
        Escribir "                                              ¡Felicitaciones **** Negras ganan!!!"
		pausaGeneral()
		ganadores = 1
    Fin Si
Fin SubProceso

subProceso moverFicha(tablero, desdeX, desdeY, hastaX, hastaY, turno, fichaEnemiga)
    Definir deltaX, deltaY Como Entero
    Definir capturarX, capturarY Como Entero
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
                        movimientosDama(tablero, desdeX, desdeY, hastaX, hastaY, deltaX, deltaY, fichaEnemiga)
                    Fin Si
                Fin Si
            Sino
                Escribir "                                              Movimiento no valido"
            Fin Si
        Fin Si
    Fin Si
FinSubProceso

SubProceso movimientosDama(tablero, desdeX, desdeY, hastaX, hastaY, deltaX, deltaY, fichaEnemiga)
    Definir capturarX, capturarY, i, signoX, signoY Como Entero
    Definir movimientoValido Como Logico
    movimientoValido = Verdadero
    
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
	FinSi
	
	Si Abs(deltaX) = Abs(deltaY) Entonces
		
		Para i = 1 Hasta Abs(deltaX) - 1 Hacer
            Si tablero[desdeY + i * signoY, desdeX + i * signoX] <> " " Entonces
				Si (tablero[desdeY + i * signoY, desdeX + i * signoX] = "N" o tablero[desdeY + i * signoY, desdeX + i * signoX] = "B") Entonces
					// Contar si hay fichas del oponente en el camino
					Si (tablero[desdeY, desdeX] = "R" y (tablero[desdeY + i * signoY, desdeX + i * signoX] = "N" o tablero[desdeY + i * signoY, desdeX + i * signoX] = "B")) o (tablero[desdeY, desdeX] = "D" y (tablero[desdeY + i * signoY, desdeX + i * signoX] = "N" o tablero[desdeY + i * signoY, desdeX + i * signoX] = "B")) Entonces
						fichaEnemiga = 1
						capturarX = desdeX + i * signoX
						capturarY = desdeY + i * signoY
					Sino
						movimientoValido = Falso
					Fin Si	
				Sino
					// si hay una ficha que no es del oponente 
					movimientoValido = Falso
				FinSi
			fin si 		
		fin para
		
		// solo puede capturar una ficha enemiga en la misma diagonal
        Si fichaEnemiga = 1 y movimientoValido Entonces
			// Verificar que la casilla final esté vacía para realizar la captura
            Si tablero[hastaY, hastaX] = " " Entonces
				// realizar la captura
                tablero[capturarY, capturarX] = " "  
                tablero[hastaY, hastaX] = tablero[desdeY, desdeX]  
                tablero[desdeY, desdeX] = " "  
            Sino
                Escribir "                                              La casilla final no está vacía."
            Fin Si
			
		Sino
			Si fichaEnemiga = 0 y movimientoValido Entonces
				
				// Movimiento simple sin captura
				Si tablero[hastaY, hastaX] = " " Entonces
					tablero[hastaY, hastaX] = tablero[desdeY, desdeX] 
					tablero[desdeY, desdeX] = " " 
				Sino
					Escribir "                                              La casilla final no está vacía."
				Fin Si
				
			SiNo
				Escribir "                                              Movimiento no válido, hay más de una ficha enemiga o un obstáculo en el camino."
			FinSi
		FinSi
	Sino
        Escribir "                                              Movimiento no válido, las damas solo se mueven en diagonal."	
		
	FinSi
	
Fin SubProceso

SubProceso movimientosNormales(tablero, desdeX, desdeY, hastaX, hastaY, turno, deltaY, deltaX, fichaEnemiga)
    // validación de direccion correcta 
	Si (turno = "N" y deltaY >= 0) o (turno = "B" y deltaY <= 0) Entonces
		Escribir "                                              Movimiento no valido. Las fichas solo se mueven hacia adelante."
	Sino
		// verificar si el movimiento es de un espacio diagonal
		Si (Abs(deltaX) = 1 y Abs(deltaY) = 1) Entonces
			// movimiento simple sin captura
			Si tablero[hastaY, hastaX] = " " Entonces
				tablero[hastaY, hastaX] = tablero[desdeY, desdeX]
				tablero[desdeY, desdeX] = " "
			Sino
				Escribir "                                              La casilla final no está vacía."
			Fin Si
			// verificar si es un movimiento de captura
		Sino Si (Abs(deltaX) = 2 y Abs(deltaY) = 2) Entonces
				capturarX = desdeX + (deltaX / 2)
				capturarY = desdeY + (deltaY / 2)
				// verificar que hay una ficha para capturar
				Si tablero[capturarY, capturarX] = " " Entonces
					Escribir "                                              No hay ficha para capturar."
				Sino
					// verificar si es una ficha enemiga 
					Si (turno = "N" y tablero[capturarY, capturarX] = "B") o (turno = "N" y tablero[capturarY, capturarX] = "R") o (turno = "B" y tablero[capturarY, capturarX] = "N") o (turno = "B" y tablero[capturarY, capturarX] = "D") Entonces
						// realizar la captura
						tablero[capturarY, capturarX] = " "
						tablero[hastaY, hastaX] = tablero[desdeY, desdeX]
						tablero[desdeY, desdeX] = " "
						fichaEnemiga = 1
					Sino
						Escribir "                                              Solo puedes capturar fichas del oponente."
					Fin Si
				Fin Si
			Sino
				Escribir "                                              Movimiento no valido. Solo puedes moverte un espacio diagonal o capturar."
			Fin Si
		Fin Si
	fin si
	
	Si turno = "N" y hastaY = 1 Entonces
		tablero[hastaY, hastaX] = "D" 
	Fin Si
	Si turno = "B" y hastaY = 8 Entonces
		tablero[hastaY, hastaX] = "R" 
	Fin Si
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
	Definir pausa Como caracter 
	Escribir "                                                 Presione Enter para continuar...."
    Leer pausa
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
	Definir pausa Como entero
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
    Leer pausa
FinSubProceso

SubProceso inicio
	Escribir "                                                 +-------------------------------------------+"
    Escribir "                                                 |                                           |"
    Escribir "                                                 |                                           |"
    Escribir "                                                 |                                           |"
    Escribir "                                                 |     ____    _    __  __    _    ____      |"
    Escribir "                                                 |    |  _ \  / \  |  \/  |  / \  / ___|     |"
    Escribir "                                                 |    | | | |/ _ \ | |\/| | / _ \ \___ \     |"
    Escribir "                                                 |    | |_| / ___ \| |  | |/ ___ \ ___) |    |"
    Escribir "                                                 |    |____/_/   \_\_|  |_/_/   \_\____/     |"
    Escribir "                                                 |                                           |"
    Escribir "                                                 |                                           |"
    Escribir "                                                 |                                           |"
    Escribir "                                                 +-------------------------------------------+"
	pausaGeneral()
FinSubProceso

SubProceso inicioJuego(ganador, turno, tablero, desdeX, desdeY, hastaX, hastaY, turno, fichaEnemiga)
	Si ganador <> 1 Entonces
		Escribir "                                              Es el turno de las fichas ", turno
		Repetir
			flag = 0
			Escribir "                                              Introduce la posición inicial (x y): "
			Leer desdeX, desdeY
			Si desdeX < 1 o desdeX > 8 o desdeY < 1 o desdeY > 8 Entonces
				Escribir "                                              Coordenadas iniciales fuera del rango. Deben estar entre 1 y 8."
				flag = 0 
			Sino
				flag = 1
			Fin Si
		Hasta Que flag = 1    
		Repetir
			flag = 0
			Escribir "                                              Introduce la posición final (x y): "
			Leer hastaX, hastaY
			Si hastaX < 1 o hastaX > 8 o hastaY < 1 o hastaY > 8 Entonces
				Escribir "                                              Coordenadas finales fuera del rango. Deben estar entre 1 y 8."
				flag = 0 
			Sino
				flag = 1
			Fin Si
		Hasta Que flag = 1
		moverFicha(tablero, desdeX, desdeY, hastaX, hastaY, turno, fichaEnemiga)
	FinSi
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
				inicioJuego(ganador, turno,tablero, desdeX, desdeY, hastaX, hastaY, turno, fichaEnemiga)
                Si turno = "N" Entonces
                    turno = "B"
                Sino
                    turno = "N"
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
