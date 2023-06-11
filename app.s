.include "datos.s"
.include "geometria.s"
.include "objetos.s"
.include "graficos.s"


	//.equ SCREEN_WIDTH,   640
	//.equ SCREEN_HEIGH,   480
	//.equ BITS_PER_PIXEL, 32
	//

	.globl main


// Último indice tomando los elementos como dword
.equ SCREEN_PIXELS_div_2_menos_1, SCREEN_PIXELS/2 - 1
screen_pixels_div_2_menos_1: .dword SCREEN_PIXELS_div_2_menos_1 // Último indice tomando los elementos como dword
actualizarFrameBuffer:
        ldr x9, dir_frameBuffer
        ldr x10, screen_pixels_div_2_menos_1
    loop_actualizarFrameBuffer:
        cmp x10, #0
        b.lt end_loop_actualizarFrameBuffer
        ldr x11, [x0, x10, lsl #3] // Voy copiando los colores de a 2
        str x11, [x9, x10, lsl #3]
        sub x10, x10, #1
        b loop_actualizarFrameBuffer
    end_loop_actualizarFrameBuffer:
        br lr // return
//


/* crearDelay:
    Hace un gran loop para crear delay, el tiempo de delay depende de la constante delay.

    Utiliza x9.
 */
crearDelay:
        ldr x9, delay
    loop_crearDelay:
        subs x9, x9, 1
        b.ne loop_crearDelay

        br lr // return
//

// x0 contiene la direccion base del framebuffer
	mov x20, x0 // Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------

	

main:   

  adr x1, dir_frameBuffer
  str x0, [x1] // Guardo la dirección de memoria del frame-buffer en dir_frameBuffer
  ldr x0, =bufferSecundario // Pongo en x0 la dirección base del buffer secundario


	// Ejemplo de uso de gpios
	mov x9, GPIO_BASE

	// Atención: se utilizan registros w porque la documentación de broadcom
	// indica que los registros que estamos leyendo y escribiendo son de 32 bits



	// Setea gpios 0 - 9 como lectura
str wzr, [x9, GPIO_GPFSEL0]

 // 0b00000010 == w  
 // 0b00000100 == s  
 // 0b00001000 == d
 // 0b00010000 == esp

reset:
mov x2, 0
mov x3, 0
mov x18, 400
mov x19, 160
mov x24, 0
mov x25, 0
mov x5, 0
InfLoop:
    
	bl pintarCielo

	bl pintarSol

	bl pintarFondo

  bl personaje
  
  cbz x5, noBola
  bl bolaDeFuego
noBola:
  
  
	bl actualizarFrameBuffer  


	// Lee el estado de los GPIO 0 - 31
  mov x9, GPIO_BASE

  // Setea gpios 0 - 9 como lectura
  str wzr, [x9, GPIO_GPFSEL0]

  ldr w10, [x9, GPIO_GPLEV0]

  and w11, w10, 0b00000010
  and w12, w10, 0b00000100  // a
  and w13, w10, 0b00001000  // s
  and w14, w10, 0b00010000  // d
  and w15, w10, 0b00100000  // espacio
  cbz w12, noMoverPersIzq
  sub x18, x18, 1
  bl crearDelay
noMoverPersIzq:
 

  cbz w14, noMoverPersDer
  add x18, x18, 1
  bl crearDelay
noMoverPersDer:




// si W no esta precionado no salta
  cbz w11, noSaltar
  mov x24, 40
  mov x25, 40
noSaltar:
  //Si x24 es 0 termino de subir (o no se presiono)
  cbz x24, terminoSubir
  //Aca abajo todavia no termino el salto por lo que
  //seguimos restando a x19 para que suba y decrementamos
  // x24 hasta que sea 0 asi deja de saltar
  sub x19, x19, 2
  sub x24, x24, 1
terminoSubir:
  cmp x19, 160
  b.eq terminoBajar
  // en el caso de x24 no siendo cero es que no termino de subir
  cbnz x24, terminoBajar
  add x19, x19, 2
terminoBajar:
  




  cbz w15, noBolaDeFuego
  mov x5, 100
noBolaDeFuego:

  cbz x5, noAnimacionBola
  sub x5, x5, 1
noAnimacionBola:

  cbz w13, nomover 
  add x2, x2, 1
  add x3, x3, 1
  bl crearDelay
  cmp x3, 450
  b.gt reset
nomover:

	b InfLoop

