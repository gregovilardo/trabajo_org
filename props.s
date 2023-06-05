.ifndef props_s
.equ props_s, 0 

.include "datos.s"
.include "graficos.s"

.data
//Suelo y cielo
.equ posicionInicialX, 0
.equ posicionInicialY, 250
.equ medioLargoTriangulo, 30
.equ largoTriangulo, medioLargoTriangulo*2
.equ alturaTriangulo, 300
.equ espaciado, 5
.equ colorPasto, colorArbusto



pintarPasto:
    sub sp, sp, 48
    stur x5, [sp, 40]
    stur x4, [sp, 32]
    stur x3, [sp, 24]
    stur x2, [sp, 16]
    stur x1, [sp, 8]
    stur lr, [sp, 0]
    mov x9, 4
pintarPasto1:
    cbz x9, end_pasto
    sub x9, x9, 1
    // x2 < x4 => x3 < x5

    ldr x1, colorPasto
    mov x2, posicionInicialX 
    mov x3, posicionInicialY 
    mov x4, medioLargoTriangulo 
    mov x5, alturaTriangulo 
    
    bl pintarTrianguloDown
  lp:
    cmp x2, 640
    b.gt endlp
    add x2, x2, largoTriangulo + espaciado 
    add x4, x2, medioLargoTriangulo
    bl pintarTrianguloDown
    b lp

    //Termina los primeros triangulos
  endlp:
  .equ posicionInicialX, 110
  .equ posicionInicialY, 250
  .equ medioLargoTriangulo, 30
  .equ largoTriangulo, medioLargoTriangulo*2
  .equ alturaTriangulo, 440
  .equ espaciado, 10
  .equ colorPasto, colorRopaNinja

  b pintarPasto1
end_pasto:


    ldur x5, [sp, 40]
    ldur x4, [sp, 32]
    ldur x3, [sp, 24]
    ldur x2, [sp, 16]
    ldur x1, [sp, 8]
    ldur lr, [sp, 0]
    add sp, sp, 48
    br lr





.endif

