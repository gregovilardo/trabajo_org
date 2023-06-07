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
	ldr w1, colorCielo4
	ldr w24, degradado_r1
	mov x2, 0
	mov x3, 0
	mov x4, 640
	mov x5, anchoPiso
	bl pintarRectangulo


//Sol:
// w1 es el color donde empieza, se va agregando w24 hasta llegar a w26
// w1 < w26
   ldr w1, colorSol1
   mov x2, 220
   mov x3, 240
   mov x4, 80
   ldr w24, degradado_g1
   ldr w26, colorSol2
   bl pintarCirculo

//Luna:
  ldr w1, colorLuna1
  mov x2, 470
  mov x3, 80
  mov x4, 30
  ldr w24, degradado
  ldr w26, colorLuna2
  bl pintarCirculo

  ldr w1, colorCrater1
  mov x2, 478
  mov x3, 90
  mov x4, 7
  ldr w24, degradado
  ldr w26, colorCrater2
  bl pintarCirculo

  ldr w1, colorCrater1
  mov x2, 460
  mov x3, 70
  mov x4, 7
  ldr w24, degradado
  ldr w26, colorCrater2
  bl pintarCirculo

// Pasto: 
	ldr x1, colorTierraFondo
	ldr x24, negro
	mov x2, 0
	mov x3, 250
	mov x4, 640
	mov x5, 480
	bl pintarRectangulo

	bl pintarPasto
  bl pintarCavernicola
   mov x2, 50
   bl pintarPino2
   add x2, x2, 150
   bl pintarPino
   add x2, x2, 200
   bl pintarPino2

	//ldr x1, colorArbusto
	//mov x2, 120			//x2 = Coordenada del centro en x
	//mov x3, 240			//x3 = Coordenada del centro en y
	//mov x4, 100		//x4 = Radio							
	//mov x5, 1			//x5 = separacion entre circulos  
	//mov x6, 400
	//bl circulos_horizontales



  //llamadas a pintarNube:

  /* x0 = direccion base del framebuffer
   w1 = color
   x2 = coordenada del centro en x
   x3 = coordenada del centro en y
   x4 = radio
   x5 = distancia entre circulos
   x6 = coordenada destino x, luego llamamos a circulos_horizontales */ 

   //nube 1
   ldr x1, colorNubes
   mov x2, 90
   mov x3, 90 
   mov x4, 10
   mov x5, 15 //distancia entre nubes
   mov x6, 160
   bl pintarNube
   
   ldr x1, colorNubes
   mov x2, 97
   mov x3, 80 
   mov x4, 10
   mov x5, 15 //distancia entre nubes
   mov x6, 150
   bl pintarNube
 
 //nube 2
   ldr x1, colorNubes
   mov x2, 240
   mov x3, 170
   mov x4, 10
   mov x5, 15 //distancia entre nubes
   mov x6, 300
   bl pintarNube

   ldr x1, colorNubes
   mov x2, 247
   mov x3, 160
   mov x4, 10
   mov x5, 15 //distancia entre nubes
   mov x6, 295
   bl pintarNube

//nube 3
   ldr x1, colorNubes
   mov x2, 390
   mov x3, 80
   mov x4, 15
   mov x5, 1 //distancia entre nubes
   mov x6, 430
   bl pintarNube

   ldr x1, colorNubes
   mov x2, 397
   mov x3, 70
   mov x4, 15
   mov x5, 15 //distancia entre nubes
   mov x6, 420
   bl pintarNube



  




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
