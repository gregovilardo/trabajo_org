.ifndef datos_s
.equ datos_s, 0 

.data

// Pantalla:
bufferSecundario: .skip BYTES_FRAMEBUFFER
delay: .dword 0xffff  // A mayor número mas lento va la animación



.equ SCREEN_WIDTH, 640
.equ SCREEN_HEIGH, 480
.equ SCREEN_PIXELS, SCREEN_WIDTH * SCREEN_HEIGH
.equ BYTES_PER_PIXEL, 4
.equ BITS_PER_PIXEL, 8 * BYTES_PER_PIXEL
.equ BYTES_FRAMEBUFFER, SCREEN_PIXELS * BYTES_PER_PIXEL
dir_frameBuffer: .dword 0 // Variable para guardar la dirección de memoria del comienzo del frame buffer




// Gpios:

.equ GPIO_BASE,    0x3f200000
.equ GPIO_GPFSEL0, 0x00
.equ GPIO_GPLEV0,  0x34





//Suelo y cielo
.equ alturaSuelo, 250
.equ alturaArbol, 80
.equ anchoArbol, alturaArbol/6
.equ alturaArbusto, 120
.equ anchoArbusto, 50
.equ alturaNube, 90
.equ anchoNube, 90

.equ anchoPiso, 250

.equ alturaCavernicola, 160


//Colores:
blanco: .word 0xffffff
negro: .word 0x000000
coloRojo: .word 0xff0000

degradado_r1: .word 0x010000
degradado_g1: .word 0x000100
degradado_b1: .word 0x000001
degradado:    .word 0x010101



//entorno: 
colorArbusto: .word 0x6ead6a //verde claro
colorArbustoBorde: .word 0x51854d //verde oscuro 
colorHoja: .word 0x41874f 

colorPasto1: .word 0x35692d
colorPasto2: .word 0x156321
colorPastoSombra: .word 0x5e2714

colorTierraFondo: .word 0x653830 //marron oscuro
colorTierraMedio: .word 0x7c3b1a //marron claro
colorPino: .word 0x8d733b //marron oscuro


//personajes 
colorSombrero: .word 0x66280a // marron oscuro 
colorPielPersonaje: .word 0xe6b8bb //color crema 
colorNaranja: .word 0xff8000 //naranja 
colorNaranja2: .word 0xff9e04 //naranja2
colorRojo: .word  0xff0000 //rojo




colorRopaNinja: .word  0xff0000 //rojo
colorRopaNinja2: .word 0xe0e0e0 //gris

//fondo

colorCielo: .word  0x00abf5//celeste clarito
colorCielo2: .word 0x0099ff //celeste
colorCielo3: .word 0x0080ff //celeste oscuro
colorCielo4: .word 0x008bab //celeste oscuro


colorNubes: .word  0xfffffa //blanco
colorNubes2: .word 0xe0e0e0 //gris 
colorHueso: .word 0xffefb6

colorSol1: .word 0xff8000 //naranja
colorSol2: .word 0xffee00 //amarillo



colorLuna1: .word 0xa0a0a9 //gris oscuro
colorLuna2: .word 0xe0e0e0 //gris 
colorCrater1: .word 0xa0a0a0 //gris + oscuro
colorCrater2: .word 0xd4d4d4 //negro
.endif
