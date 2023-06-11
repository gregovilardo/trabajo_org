.ifndef graficos_s
.equ graficos_s, 0 
.include "datos.s"
.include "geometria.s"
.include "objetos.s"


pintarFondo:

sub sp, sp, 88
stur lr, [sp, 80]
stur x1, [sp, 72]
stur x2, [sp, 64]
stur x3, [sp, 56]
stur x4, [sp, 48]
stur x5, [sp, 40]
stur x6, [sp, 32]
stur x7, [sp, 24]
stur x8, [sp, 16]
stur x24, [sp, 8]
stur x26, [sp]

// Cielo
//	ldr w1, colorCielo4
//	ldr w24, degradado_r1
//	mov x2, 0
//	mov x3, 0
//	mov x4, 640
//	mov x5, anchoPiso
//	bl pintarRectangulo


//Sol:
// w1 es el color donde empieza, se va agregando w24 hasta llegar a w26
// w1 < w26
//   ldr w1, colorSol1
//   mov x2, 220
//   mov x3, 240
//   mov x4, 80
//   ldr w24, degradado_g1
//   ldr w26, colorSol2
//   bl pintarCirculo

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
   
   /* nubes */
   ldr x1, colorNubes
   
   mov x2, 330  // Coordenada inicial x
   mov x3, 100  // Coordenada y
   mov x4, 8  // Radio inicial
   mov x5, 16 // Separacion Burbujas
   mov x6, 362  // Coordenada centro x
   mov x7, 4 // Aumento radio
   bl nube
   mov x2, 16  // Coordenada inicial x
   mov x3, 50  // Coordenada y
   mov x4, 16 // Radio inicial
   mov x5, 32 // Separacion Burbujas
   mov x6, 80  // Coordenada centro x
   mov x7, 6 // Aumento radio
   bl nube
   mov x2, 170  // Coordenada inicial x
   mov x3, 110  // Coordenada y
   mov x4, 8  // Radio inicial
   mov x5, 16 // Separacion Burbujas
   mov x6, 202  // Coordenada centro x
   mov x7, 3 // Aumento radio
   bl nube
   // Pasto: 
   	 ldr x1, colorTierraFondo
   	 ldr x24, negro
   	 mov x2, 0
   	 mov x3, 250
   	 mov x4, 640
   	 mov x5, 480
   	 bl pintarRectangulo
   
   	 bl pintarPasto
   
     // Pinos
      mov x2, 50
      bl pintarPino2
      add x2, x2, 150
      bl pintarPino
      add x2, x2, 200
      bl pintarPino2
   
   
   /* huesoHorizontal:
     Parametros:
       x2 = comienzo hueso (izq) en x
       x3 = comienzo hueso (izq) en y
       x4 = final hueso (der) en x
       x5 = final hueso (der) en y
      */
     mov x2, 145
     mov x3, 390
     mov x4, 215
     mov x5, 405
     bl huesoHorizontal  
   
   // huesoVertical:
   //  Parametros:
   //    x2 = comienzo hueso (izq) en x
   //    x3 = comienzo hueso (izq) en y
   //    x4 = final hueso (der) en x
   //    x5 = final hueso (der) en y
   //   */
   
     mov x2, 235
     mov x3, 395
     mov x4, 250
     mov x5, 465
     bl huesoVertical
   
    /* Cabeza Dinosaurio
       Parámetros:
           x0 = Dirección base del arreglo
           w1 = Color
           x2 = Coordenada del centro en x
           x3 = Coordenada del centro en y
           x4 = Radio
           x5 = (separacion de circulos)
           x6 = coordenada destino x
           x7 = aumento de radio
   */
    mov x2, 240
    mov x3, 325 
    mov x4, 15
    mov x6, 290   // radio final = x4 + (x6 - x2)/x5*x7
    mov x5, 8
    mov x7, 3
    mov x8, 4  
   bl cabezaDinosaurio


ldur lr, [sp, 80]
ldur x1, [sp, 72]
ldur x2, [sp, 64]
ldur x3, [sp, 56]
ldur x4, [sp, 48]
ldur x5, [sp, 40]
ldur x6, [sp, 32]
ldur x7, [sp, 24]
ldur x8, [sp, 16]
ldur x24, [sp, 8]
ldur x26, [sp]
add sp, sp, 88
br lr


/* CIELO */

pintarCielo:
sub sp, sp, 56
stur lr, [sp, 48]
stur x1, [sp, 40]
stur x2, [sp, 32]
stur x3, [sp, 24]
stur x4, [sp, 16]
stur x5, [sp, 8]
stur x24, [sp]

  ldr w1, colorCielo4
	ldr w24, degradado_r1
	mov x2, 0
	mov x3, 0
	mov x4, 640
	mov x5, anchoPiso
	bl pintarRectangulo

ldur lr, [sp, 48]
ldur x1, [sp, 40]
ldur x2, [sp, 32]
ldur x3, [sp, 24]
ldur x4, [sp, 16]
ldur x5, [sp, 8]
ldur x24, [sp]
add sp, sp, 56
br lr

/* SOL */
pintarSol:
sub sp, sp, 48
stur lr, [sp, 40]
stur x1, [sp, 32]
stur x2, [sp, 24]
stur x3, [sp, 16]
stur x24, [sp, 8]
stur x26, [sp]
ldr w1, colorSol1
//mov x2, 220
//mov x3, 330
mov x4, 80
ldr w24, degradado_g1
ldr w26, colorSol2
bl pintarCirculo

ldur lr, [sp, 40]
ldur x1, [sp, 32]
ldur x2, [sp, 24]
ldur x3, [sp, 16]
ldur x24, [sp, 8]
ldur x26, [sp]
add sp, sp, 48
br lr

.endif
