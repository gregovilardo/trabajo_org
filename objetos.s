.ifndef objetos_s
.equ objetos_s, 0 
.include "datos.s"
.include "geometria.s"

.data
//Suelo y cielo
.equ posicionInicialX, 0
.equ posicionInicialY, 250
.equ medioLargoTriangulo, 30
.equ alturaTriangulo, 300
.equ espaciado, 5


bolaDeFuego:
  sub sp, sp, 152
  stur x11, [sp, 144] 
  stur x12, [sp, 136]
  stur x13, [sp, 128]
  stur x14, [sp, 120]
  stur x15, [sp, 112] 
  stur x25, [sp, 104]
  stur x24, [sp, 96]
  stur x19, [sp, 88]
  stur x18, [sp, 80]
  stur x24, [sp, 72]
  stur x21, [sp, 64]
  stur x8, [sp, 56]
  stur x7, [sp, 48]
  stur x6, [sp, 40]
  stur x5, [sp, 32]
  stur x4, [sp, 24]
  stur x3, [sp, 16]
  stur x2, [sp, 8]
  stur lr, [sp, 0]

  ldr w1, colorRojo
  sub x2, x18, 30
  add x3, x19, 30
  mov x4, 14
  mov x5, 2
  mov x6, 0
  mov x7, 0
  mov x8, 0
  bl circulos_horizontales
  
  ldur x11, [sp, 144] 
  ldur x12, [sp, 136]
  ldur x13, [sp, 128]
  ldur x14, [sp, 120]
  ldur x15, [sp, 112] 
  ldur x25, [sp, 104]
  ldur x24, [sp, 96]
  ldur x19, [sp, 88]
  ldur x18, [sp, 80]
  ldur x24, [sp, 72]
  ldur x21, [sp, 64]
  ldur x8, [sp, 56]
  ldur x7, [sp, 48]
  ldur x6, [sp, 40]
  ldur x5, [sp, 32]
  ldur x4, [sp, 24]
  ldur x3, [sp, 16]
  ldur x2, [sp, 8]
  ldur lr, [sp, 0]
  add sp, sp, 152
  br lr

personaje:
  sub sp, sp, 112
  stur x25, [sp, 104]
  stur x24, [sp, 96]
  stur x19, [sp, 88]
  stur x18, [sp, 80]
  stur x24, [sp, 72]
  stur x21, [sp, 64]
  stur x8, [sp, 56]
  stur x7, [sp, 48]
  stur x6, [sp, 40]
  stur x5, [sp, 32]
  stur x4, [sp, 24]
  stur x3, [sp, 16]
  stur x2, [sp, 8]
  stur lr, [sp, 0]


  //cabeza
  ldr w1, colorPielPersonaje
  mov x2, x18
  mov x3, x19
  mov x4, 15
  ldr w25, negro
  ldr w26, blanco   //para no hacer degradado
  bl pintarCirculo

//sombrero
 ldr w1, negro
 sub x2, x18, 10
 sub x3, x19, 2
 mov x4, 2
 bl pintarCirculo


ldr w1, colorSombrero
sub x2, x18, 20
sub x3, x19, 14
mov x4, 2
mov x5, 2
add x6, x18, 22
mov x7, 0
mov x8, 0
bl circulos_horizontales

ldr w1, colorSombrero
mov x2, x18
sub x3, x19, 36
add x4, x18, 12
sub x5, x19, 16
bl pintarTriangulo

ldr w1, colorNaranja
sub x2, x18, 15
sub x3, x19, 17
mov x4, 1
mov x5, 1
add x6, x18, 15
mov x7, 0
mov x8, 0
bl circulos_horizontales

//remera
ldr w1, colorNaranja2
sub x2, x18, 8
add x3, x19, 14
add x4, x18, 8
add x5, x19, 54
bl pintarRectangulo

//brazo
ldr w1, colorPielPersonaje
mov x2, x18
add x3, x19, 20
mov x4, 2
mov x5, 2
add x6, x19, 40
bl circulos_verticales


//pantalon
ldr w1, colorSombrero
sub x2, x18, 8
add x3, x19, 43
add x4, x18, 8
add x5, x19, 78
bl pintarRectangulo

ldr w1, colorSombrero
sub x2, x18, 8
add x3, x19, 43
add x4, x18, 8
add x5, x19, 78
bl pintarRectangulo

//zapatillas 
ldr w1, negro
sub x2, x18, 10
add x3, x19, 79
add x4, x18, 6
add x5, x19, 89
bl pintarRectangulo

  ldur x25, [sp, 104]
  ldur x24, [sp, 96]
  ldur x19, [sp, 88]
  ldur x18, [sp, 80]
  ldur x24, [sp, 72]
  ldur x21, [sp, 64]
  ldur x8, [sp, 56]
  ldur x7, [sp, 48]
  ldur x6, [sp, 40]
  ldur x5, [sp, 32]
  ldur x4, [sp, 24]
  ldur x3, [sp, 16]
  ldur x2, [sp, 8]
  ldur lr, [sp, 0]
  add sp, sp, 112
  br lr

 plantarPino:
  sub sp, sp, 16
  stur lr, [sp, 8]
  stur x2, [sp]
  mov x2, x18
  sub x2, x2, 10
  bl pintarPino2

noPlantarPino:
  ldur lr, [sp, 8]
  ldur x2, [sp]
  add sp, sp, 16
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
  sub x5, x5, 1  //Para que no pinte la linea del suelo
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
  sub x5, x5, 1  //Para que no pinte la linea del suelo
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



/* huesoHorizontal:
  Parametros:
    w1 = color
    x2 = comienzo hueso (izq) en x
    x3 = comienzo hueso (izq) en y
    x4 = final hueso (der) en x
    x5 = final hueso (der) en y
    
   */
huesoHorizontal:
  sub sp, sp, 40 
  stur lr, [sp, 40] 
  stur x6, [sp, 32]
  stur x5, [sp, 24]
  stur x4, [sp, 16]
  stur x2, [sp, 8] 
  stur x1, [sp]
 
  ldr x1, colorHueso //cargo en x1 el color
  // el largo y ancho del hueso es un rectangulo
  bl pintarRectangulo 
   sub x9, x4, x2 // x9 = largo del hueso en x
   sub x10, x5, x3  // x10 = ancho del hueso en y
   // para ambos extremos:
   // el radio de los circulos de los extremos del hueso es 2/3 el ancho del hueso 
   lsl x4, x10, 1 
   mov x11, 3  // aux
   udiv x4, x4, x11  // x4 = 2/3(ancho hueso)
   // dejo de hacer circulos cuando llego a la coordenada y2 
   mov x6, x5 
   // la separacion entre circulos es el ancho del hueso (hay un circulo en cada esquina del rectangulo)
   mov x5, x10 
   mov x7, 0 // no quiero alterar el tamaño del radio
   bl circulos_verticales  // pinta extremo izquierdo
   add x2, x2, x9  // voy del extremo izquierdo al extremo derecho 
   bl circulos_verticales // pinta extremo derecho
 
  ldur lr, [sp, 40] // Guardo el puntero de retorno en el stack
  ldur x6, [sp, 32]
  ldur x5, [sp, 24]
  ldur x4, [sp, 16]
  ldur x2, [sp, 8] 
  ldur x1, [sp]
  add sp, sp, 40
  br lr


  /* huesoVertical:
  Parametros:
    w1 = color
    x2 = comienzo hueso (izq) en x
    x3 = comienzo hueso (izq) en y
    x4 = final hueso (der) en x
    x5 = final hueso (der) en y
    
   */
huesoVertical:
  sub sp, sp, 48 
  stur lr, [sp, 40] 
  stur x6, [sp, 32]
  stur x5, [sp, 24]
  stur x4, [sp, 16]
  stur x2, [sp, 8] 
  stur x1, [sp]
 
  ldr x1, colorHueso //cargo en x1 el color
  // el largo y ancho del hueso es un rectangulo
  bl pintarRectangulo 
  // ahora vamos a usar una columna de dos circulos para hacer los extremos 

  /*
        x0 = Dirección base del arreglo
        w1 = Color
        x2 = Coordenada del centro en x
        x3 = Coordenada del centro en y
        x4 = Radio
        x5 = distancia entre circulos
        x6 = coordenada destino y
   */
   sub x9, x5, x3 // x9 = largo del hueso en y
   sub x10, x4, x2  // x10 = ancho del hueso en x
   mov x14, x4  // registro auxiliar
   // para ambos extremos:
   // el radio de los circulos de los extremos del hueso es 2/3 el ancho del hueso en x
   lsl x4, x10, 1 
   mov x11, 3  // aux
   udiv x4, x4, x11  // x4 = 2/3(x2 - x1)
   mov x6, x14 // dejo de hacer circulos cuando llego a la coordenada x2 
   mov x5, x10  // la separacion entre circulos es el ancho del hueso  (hay un circulo en cada esquina del rectangulo)
   mov x7, 0  // no quiero aumentar radio
   mov x8, 0  // no quiero usar este parametro secundario para aumentar el y
   bl circulos_horizontales  // pinta extremo superior
   add x3, x3, x9  // voy del extremo superior al extremo inferior
   bl circulos_horizontales // pinta extremo inferior
 
  ldur lr, [sp, 40] 
  ldur x6, [sp, 32]
  ldur x5, [sp, 24]
  ldur x4, [sp, 16]
  ldur x2, [sp, 8] 
  ldur x1, [sp]
  add sp, sp, 48


  br lr

/* Cabeza Dinosaurio
    Parámetros:
        x0 = Dirección base del arreglo
        w1 = Color
        x2 = Coordenada del centro en x
        x3 = Coordenada del centro en y
        x4 = Radio
        x5 = separacion de circulos
        x6 = coordenada destino x
        x7 = aumento de radio
*/
 cabezaDinosaurio:
  sub sp, sp, 16
  stur x26, [sp, 8]
  stur lr, [sp]
 ldr x1, colorHueso //guardo color en x1
  mov x22, x2
  mov x23, x3
  mov x26, x4
  mov x21, x6
  //voy a hacer el craneo
  bl circulos_horizontales
  sub x9, x2, x4 // x9 = Coordenada lateral izquierdo del craneo en x
  add x10, x6, x4 // x10 = Coordenada lateral derecho del craneo en x 
  sub x11, x10, x9 // x11 = largo del craneo en x
   // radio final = x4 + (x6 - x2)/x5*x7
  sub x17, x6, x2 // x17 = distancia del perimer al ultimo radio
  udiv x12, x17, x5
  mul x12, x12, x7
  add x12, x4, x12  // x12 = radio final

  //voy a hacer una concavidad para el ojo
  ldr x1, colorTierraFondo //guardo color concavidad 
  mov x2, x6  // la concavidad esta en el centro de la circunferencia final en x
  lsr x13, x12, 1 // x13 = mitad del radio final
  sub x3, x3, x13 // la concavidad esta en el centro de las circunferencias menos la mitad del radio final en y
  lsr x4, x26, 1 // el radio de la concavidad es la mitad del radio inicial
  bl pintarCirculo
  // voy a hacer una segunda concavidad
  lsl x14, x4, 1 // x14 = diametro de la concavidad 1
  mov x15, 3
  udiv x15, x4, x15 // x15 = 1/3 radio de concavidad 1
  lsl x4, x15, 1 // el radio de la concavidad 2 es 2/3 el radio de la concavidad 1 
  add x3, x3, x4 // me desplazo 2/3 de radio de la concavidad 1 hacia abajo
  sub x2, x2, x14 // me dezplazo un diametro de la concavidad 1 a la izquierda
  bl pintarCirculo
  // voy a hacer la mandibula
  
  //cola
  ldr x1, colorHueso
  sub x2, x21, x22  // comienza en x en el centro del circulo mas grande
  add x2, x22, x17  
  add x3, x23, x17
  mov x4, x26  // radio inicial
  mov x5, x4  
  mov x9, 3
  mul x9, x12, x9
  add x6, x21, x9 
  mov x7, 0  // el radio no aumenta
  mov x9, 6
  mul x8, x8, x9  // avance en y
 
  bl circulos_horizontales

  ldur x26, [sp, 8]
  ldur lr, [sp]
  add sp, sp, 16

  br lr

 /*
 x2 = Coordenada inicio de nube
 x3 = altura de nube
 x4 = radio
 x5 = separacion entre circulos
 x6 = Coordenada centro de nube  // 
 x7 = aumento radio
  */
 nube:
 sub sp, sp, 24
 stur lr, [sp, 16]
 stur x6, [sp, 8]
 stur x2, [sp]
 mov x8, 0  // no quiero usar este parametro secundario para aumentar el y
 sub x9, x6, x2  //distancia entre los extremos y el centro
 bl circulos_horizontales  // pinto de izquierda a derecha aumentando el radio 
 add x2, x6, x9  
 bl circulos_horizontales  // pinto de izquierda a derecha aumentando el radio 
 // para que la nube quede linda hay que elegir los parametros con sabiduria
 ldur lr, [sp, 16]
 ldur x6, [sp, 8]
 ldur x2, [sp]
 add sp, sp, 24
 br lr  


.endif
