.text
.global topixel

/* Toma (x11, x22) como argumentos y devuelve en x23 esa posicion
de pixeles como una adress */ 
topixel:
    sub sp, sp, 16
    stur lr, [sp, 8]
    stur x9, [sp, 0]
    mov x9, 640
    mul x23, x22, x9      // y * 640
    add x23, x23, x11     // y * 640 + x
    lsl x23, x23, 2      // 4*(y * 640 + x )
    add x23, x23, x20    // 4*(y * 640 + x ) + direccion base
    ldur lr, [sp, 8]
    ldur x9, [sp, 0]
    add sp, sp, 16
    br lr
