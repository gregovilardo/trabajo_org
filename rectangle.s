.text
.global rectangle

rectangle:
#import topixel.s

  // Usamos x0, x1, x2, x3, x4, x5, x22
  sub sp, sp, 64
  stur lr, [sp,56]
  stur x22, [sp,48]
  stur x5, [sp,40]
  stur x4, [sp,32]
  stur x3, [sp,24]
  stur x2, [sp,16]
  stur x1, [sp, 8]
  stur x0, [sp, 0]
  mov x4, x1   
  mov x5, x2
  bl topixel // x23 = (x11, x22) en bits
  mov x0, x23

loop1:
	mov x1, x4         // X Size
loop0:
	stur w10,[x0]  // Colorear el pixel N
	add x0,x0,4    // Siguiente pixel   Esto pint la pantalla bit por bit
	sub x1,x1,1    // Decrementar contador X    
	cbnz x1,loop0  // Si no terminó la fila, salto
	sub x2,x2,1    // Decrementar contador Y (size y)
  add x22, x22, 1 // x22++, le sumo uno a la posicion y
                  // para pintar una linea debajo de la
                  // que acabo de pintar
  bl topixel      // x23 = nueva posicion
  mov x0, x23
	cbnz x2,loop1  // Si no es la última fila, salto

  ldur lr, [sp,56]
  ldur x22, [sp,48]
  ldur x5, [sp,40]
  ldur x4, [sp,32]
  ldur x3, [sp,24]
  ldur x2, [sp,16]
  ldur x1, [sp, 8]
  ldur x0, [sp, 0]
  add sp, sp, 64
  br lr  
  // END RECTANGLE
