.ifndef props_s
.equ props_s, 0 
.include "datos.s"
.include "graficos.s"

.data
//Suelo y cielo
.equ posicionInicialX, 0
.equ posicionInicialY, 250
.equ medioLargoTriangulo, 30
.equ alturaTriangulo, 300
.equ espaciado, 5


pintarCavernicola:
  sub sp, sp , 8
  stur lr, [sp, 0]

  ldr w1, colorPielCavernicola
  mov x2, 400
  mov x3, posicionInicialY - 50
  mov x4, 10
  ldr w24, negro
  ldr w26, blanco   //para no hacer degradado
  bl pintarCirculo

  ldr w1, colorPeloCavernicola
  mov x2, 380
  mov x3, posicionInicialY - 90
  add x4, x2, 20
  add x5, x3, 20
  bl pintarTrianguloRectangulo

 /*ldr w1, colorPielCavernicola
  mov x2, 400
  mov x3, 40
  mov x4, 3
  mov x5, 0
  mov x6, 50
  bl circulos_verticales*/
  
  ldur lr, [sp, 0]
  add sp, sp , 8

  br lr



/* pintarTriangulo:
    Parametros
      /* pintarTrianguloRectangulo:
    Parámetros:
        x0 = Dirección base del arreglo
        w1 = Color
        x2 = Coordenada centro en x   
        x3 = Coordenada centro en y
        x4 = Coordenada final en x
        x5 = Coordenada final en y

      (x2, x3) son la punta de la piramide

    Utiliza los registros usados por pintarPixel (x9).
    No modifica ningún parámetro.
 */

/*pintarPasto
   Parametros:
   x1 = color
   x2 = posicion inicial en x
   x3 = posicion inicial en y
   x4 = mitad del largo del triangulo
   x5 = altura del triangulo*/

pintarPasto:
  sub sp, sp, 48
  stur x5, [sp, 40]
  stur x4, [sp, 32]
  stur x3, [sp, 24]
  stur x2, [sp, 16]
  stur x1, [sp, 8]
  stur lr, [sp, 0]

  // Pinto la sombra primero
  ldr x1, colorPastoSombra
  mov x2, posicionInicialX + 2
  mov x3, posicionInicialY 
  mov x4, medioLargoTriangulo + 2
  mov x5, alturaTriangulo + 5
  mov x6,  (medioLargoTriangulo*2)+espaciado
  mov x7, medioLargoTriangulo
  bl startPintarPasto

  ldr x1, colorPasto1
  mov x2, posicionInicialX
  mov x3, posicionInicialY 
  mov x4, medioLargoTriangulo 
  mov x5, alturaTriangulo 
  mov x6, (medioLargoTriangulo*2)+espaciado
  mov x7, medioLargoTriangulo
  bl startPintarPasto

  ldr x1, colorPasto2
  mov x2, posicionInicialX + 10
  mov x4, medioLargoTriangulo 
  mov x5, alturaTriangulo - 15
  mov x6, ((medioLargoTriangulo-10)*2)+25
  mov x7, medioLargoTriangulo-10
  bl startPintarPasto

  b endPintarPasto

  startPintarPasto:
    sub sp, sp , 8
    stur lr, [sp, 0]

    bl pintarTrianguloDown
    lpasto:
      cmp x2, 640
      b.gt endlpasto
      add x2, x2, x6          // La proxima posicion inicial en x (x2) ahora es el tama;o largo del triangulo + espaciado
      add x4, x2, x7          // La cordenada final en x (x4) ahora es (largo del triangulo + espaciado) + 1/2largo del triangulo
      bl pintarTrianguloDown
      b lpasto

    endlpasto:
      ldur lr, [sp, 0]
      add sp, sp ,8
      br lr

endPintarPasto:
  ldur x5, [sp, 40]
  ldur x4, [sp, 32]
  ldur x3, [sp, 24]
  ldur x2, [sp, 16]
  ldur x1, [sp, 8]
  ldur lr, [sp, 0]
  add sp, sp, 48
  br lr


/* pintarPino:
     Perametros:
       x2 = Coordenada x 

 */

pintarPino:
    sub sp, sp, 40
    stur x5, [sp, 32]
    stur x4, [sp, 24]
    stur x3, [sp, 16]
    stur x2, [sp, 8]
    stur lr, [sp, 0]
   	/* tronco
   		  x0 = Dirección base del arreglo
           w1 = Color
           x2 = Coordenada inicial en x  // posicion inicial x
           x3 = Coordenada inicial en y  // altura piso - altura arbol
           x4 = Coordenada final en x    // posicion inicial x + ancho arbol
           x5 = Coordenada final en y    // altura piso
   	 */
	mov x9, anchoArbol/2  // x9 = centro de tronco
	mov x10, alturaArbol/2  // x10 = mitad del tronco
	mov x11, alturaArbol/4  // x11 = cuarto de tronco 
  ldr x1, colorPino
  mov x3, alturaSuelo-alturaArbol  // cima del arbol en y
  add x4, x2, anchoArbol   // lateral derecho tronco en x
  mov x5, alturaSuelo				// base del tronco en y
  bl pintarRectangulo
   	/* 
         x0 = Dirección base del arreglo
         w1 = Color
         x2 = Coordenada centro en x   
         x3 = Coordenada centro en y
         x4 = Coordenada final en x
         x5 = Coordenada final en y
        x6 = Coordenada destino en y
        x7 = Separacion triangulos

   
         (x2, x3) son la punta de la piramide
       */
  ldr x1, colorArbustoBorde
	mov x9, anchoArbol/2	
  sub x2, x4, x9	// centro arbol
	sub x3, x3, x10  // la punta del pino tiene altura 3/2 altura arbol
	sub x5, x5, x10  // la hojas llegan hasta la mitad del tronco en y
	add x4, x4, x11  // las hojas se expanden horizontalmente un cuarto de lo que mide el tronco
	
  
  bl pintarTriangulo
  
  ldur x5, [sp, 32]
  ldur x4, [sp, 24]
  ldur x3, [sp, 16]
  ldur x2, [sp, 8]
  ldur lr, [sp, 0]
  add sp, sp, 40
  br lr


/* pintarPino:
     Perametros:
       x2 = Coordenada x 

 */

   pintarPino2:
  sub sp, sp, 52
  stur x7, [sp, 44]
  stur x6, [sp, 36]
  stur x5, [sp, 32]
  stur x4, [sp, 24]
  stur x3, [sp, 16]
  stur x2, [sp, 8]
  stur lr, [sp, 0]
   	/* tronco
   		  x0 = Dirección base del arreglo
           w1 = Color
           x2 = Coordenada inicial en x  // posicion inicial x
           x3 = Coordenada inicial en y  // altura piso - altura arbol
           x4 = Coordenada final en x    // posicion inicial x + ancho arbol
           x5 = Coordenada final en y    // altura piso
   	 */
	mov x9, anchoArbol/2  // x9 = centro de tronco
	mov x10, alturaArbol/2  // x10 = mitad del tronco
	mov x11, alturaArbol/4  // x11 = cuarto de tronco 
  ldr x1, colorPino
  mov x3, alturaSuelo-alturaArbol  // cima del arbol en y
  add x4, x2, anchoArbol   // lateral derecho tronco en x
  mov x5, alturaSuelo				// base del tronco en y
  bl pintarRectangulo
   	/* 
         x0 = Dirección base del arreglo
         w1 = Color
         x2 = Coordenada centro en x   
         x3 = Coordenada centro en y
         x4 = Coordenada final en x
         x5 = Coordenada final en y
        x6 = Coordenada destino en y
        x7 = Separacion triangulos

   
         (x2, x3) son la punta de la piramide
       */
  ldr x1, colorArbustoBorde
	mov x9, anchoArbol/2	
  sub x2, x4, x9	// centro arbol
	mov x3, alturaSuelo-alturaArbol-alturaArbol/2 // la punta del pino tiene altura 3/2 altura arbol
	//sub x5, x5, x10  // la hojas llegan hasta la mitad del tronco 
	add x4, x4, x11  // las hojas se expanden horizontalmente un cuarto de lo que mide el tronco
	mov x12, alturaArbol-alturaArbol/3 // altura triangulo
//	add x5, x3, x12  // base triangulo en y
	mov x5, alturaSuelo-alturaArbol //parte superior del tronco
	lsr x7, x12, 1  // la separacion entre triannulos es la mitad de la altura de los mismos 
	mov x6, alturaSuelo-alturaArbol/3
	sub x6, x6, x7  // la base de las hojas es la mitad del tronco
	
  bl columnaTriangulos

  ldur x7, [sp, 44]
  ldur x6, [sp, 36]
  ldur x5, [sp, 32]
  ldur x4, [sp, 24]
  ldur x3, [sp, 16]
  ldur x2, [sp, 8]
  ldur lr, [sp, 0]
  add sp, sp, 52
  br lr

//proc que pinta una nube llamando a circulos_horizontales 
   pintarNube:
   sub sp, sp, 8
   stur lr, [sp, 0]
   bl circulos_horizontales
   ldur lr, [sp, 0]
   add sp, sp, 8
   br lr


.endif

