.include "graficos.s"
.include "datos.s"
.include "props.s"

	//.equ SCREEN_WIDTH,   640
	//.equ SCREEN_HEIGH,   480
	//.equ BITS_PER_PIXEL, 32
	//
	.equ GPIO_BASE,    0x3f200000
	.equ GPIO_GPFSEL0, 0x00
	.equ GPIO_GPLEV0,  0x34

	dir_frameBuffer: .dword 0 // Variable para guardar la dirección de memoria del comienzo del frame buffer

	.equ SCREEN_WIDTH, 640
	.equ SCREEN_HEIGH, 480
	.equ SCREEN_PIXELS, SCREEN_WIDTH * SCREEN_HEIGH
	.equ BYTES_PER_PIXEL, 4
	.equ BITS_PER_PIXEL, 8 * BYTES_PER_PIXEL
	.equ BYTES_FRAMEBUFFER, SCREEN_PIXELS * BYTES_PER_PIXEL



	.globl main

main: 

	// x0 contiene la direccion base del framebuffer
	mov x20, x0 // Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------

	
  adr x1, dir_frameBuffer
  str x0, [x1] // Guardo la dirección de memoria del frame-buffer en dir_frameBuffer


// Fondo
	ldr x1, colorCielo4
	ldr x24, degradado_r1
	mov x2, 0
	mov x3, 0
	mov x4, 640
	mov x5, anchoPiso
	bl pintarRectangulo

// Pasto 
	ldr x1, colorTierraFondo
	ldr x24, no_degradado
	mov x2, 0
	mov x3, 250
	mov x4, 640
	mov x5, 480
	bl pintarRectangulo

	bl pintarPasto


	//ldr x1, colorArbusto
	//mov x2, 120			//x2 = Coordenada del centro en x
	//mov x3, 240			//x3 = Coordenada del centro en y
	//mov x4, 100		//x4 = Radio							
	//mov x5, 1			//x5 = separacion entre circulos  
	//mov x6, 400
	//bl circulos_horizontales



   pino:
   	/* tronco
   		  x0 = Dirección base del arreglo
           w1 = Color
           x2 = Coordenada inicial en x  // posicion inicial x
           x3 = Coordenada inicial en y  // altura arbol
           x4 = Coordenada final en x    // posicion inicial x + ancho arbol
           x5 = Coordenada final en y    // altura piso
   	 */
   	ldr x1, colorRopaNinja
   	mov x2, 200
   	mov x3, 200		
    add x4, x2, 30
   	mov x5, 100
   	bl pintarRectangulo
   	/* 
         x0 = Dirección base del arreglo
         w1 = Color
         x2 = Coordenada centro en x   
         x3 = Coordenada centro en y
         x4 = Coordenada final en x
         x5 = Coordenada final en y
         x6 = Separacion triangulos
   
         (x2, x3) son la punta de la piramide
       */
   	mov x1, colorArbustoBorde
	mov x9, 15
   	add x2, x4, x9		// centro arbol
    mov x6, 5
    bl columnaTriangulos

 
	    




   
  /* x0 = direccion base del framebuffer
   w1 = color
   x2 = coordenada del centro en x
   x3 = coordenada del centro en y
   x4 = radio
   x5 = distancia entre circulos
   x6 = coordenada destino x */

   ldr x1, colorNubes
   mov x2, 90
   mov x3, 90 
   mov x4, 10
   mov x5, 15 //distancia entre nubes
   mov x6, 160
   //mov x7, 4 //cantidad de nubes a pintar
   bl circulos_horizontales
   
   ldr x1, colorNubes
   mov x2, 97
   mov x3, 80 
   mov x4, 10
   mov x5, 15 //distancia entre nubes
   mov x6, 150
   //mov x7, 4 //cantidad de nubes a pintar
   bl circulos_horizontales

  




//

//   ldr x1, colorNubes
//   mov x2, 90
//   mov x3, 95
//   mov x4, 10
//   mov x5, 15 //distancia entre nubes
//   mov x6, 160
//   //mov x7, 4 //cantidad de nubes a pintar
//   bl circulos_horizontales
//
//    ldr x1, colorNubes
//   mov x2, 90
//   mov x3, 95
//   mov x4, 10
//   mov x5, 15 //distancia entre nubes
//   mov x6, 160
   //mov x7, 4 //cantidad de nubes a pintar
   //bl circulos_horizontales
   
   /*loopnube:

	  bl circulos_horizontales
	  
	  add x3, x3, 30 //incremento en y para la siguiente nube
	  sub x7, x7, 1 //decremento la cantidad de nubes a pintar
	  cmp x7, 0    // si es 0, ya se pintaron todas las nubes y termino el loop, si no sigo
	  b.eq end_loop
	  b loopnube
	  
	  end_loop: */
	  

  


//	ldr x1, colorCielo
//	mov x2, 500			//x2 = Coordenada del centro en x
//	mov x3, 50			//x3 = Coordenada del centro en y
//	mov x4, 20	    //x4 = Radio							
//	mov x5, 50		//x5 = separacion entre circulos  
//	mov x6, 400
//	bl circulos_verticales
//	mov x2, 640
//	mov x3, 0
//	mov x4, 0
//	mov x5, 480
//	bl dline
//
//	mov x2, x3
//	mov x4, 640
//	mov x5, 480
//	bl dline
	
	


	// Ejemplo de uso de gpios
	mov x9, GPIO_BASE

	// Atención: se utilizan registros w porque la documentación de broadcom
	// indica que los registros que estamos leyendo y escribiendo son de 32 bits
 
 

	// Setea gpios 0 - 9 como lectura
	str wzr, [x9, GPIO_GPFSEL0]

InfLoop:
	// Lee el estado de los GPIO 0 - 31
	ldr w13, [x9, GPIO_GPLEV0]
  ldr w14, [x9, GPIO_GPLEV0]

  

	// And bit a bit mantiene el resultdo del bit 2 en w10 (notar 0b... es binario)
	// al inmediato se lo refiere como "máscara" en este caso:
	// - Al hacer AND revela el estado del bit 2
	// - Al hacer OR "setea" el bit 2 en 1
	// - Al hacer AND con el complemento "limpia" el bit 2 (setea el bit 2 en 0)
	and w13, w13, 0b00000010
 // 0b00000100 == s
 // 0b00001000 == d
 // 0b00010000 == esp
  
	and w14, w14, 0b00100000

	// si w11 es 0 entonces el GPIO 1 estaba liberado
	// de lo contrario será distinto de 0, (en este caso particular 2)
	// significando que el GPIO 1 fue presionado

	//---------------------------------------------------------------
	// Infinite Loop

//  mov x1, 0
//  mov x2, 0
//  mov x3, 640
//  mov x4, 480 
//  cbnz w13, dline
//  mov x1, 0
//  mov x2, 0
//  mov x3, 340
//  mov x4, 210 
//  cbnz w14, dline


	b InfLoop
