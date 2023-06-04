.text
.global dline

dline:
#include topixel.s

  sub sp, sp, 80
  stur x12, [sp, 72]
  stur x11, [sp, 64]
  stur x9, [sp, 56]
  stur x8, [sp, 48]
  stur x7, [sp, 40]
  stur x6, [sp, 32]
  stur x5, [sp, 24]
  stur x2, [sp, 16]
  stur x1, [sp, 8]
  stur lr, [sp, 0]
  // modificamos x1, x2, x5, x6, x7, x8, x9, x11, x22
  
  // posicion inicial (x1, x2) = (x1, y1)
  // posicion final (x3, x4) = (x2, y2)
  cmp x1, x3
  b.ne notvert
  // si x1 = x3 -> es una linea vertical
lp:
  cmp x2, x4
  b.ge end
  mov x11, x1   //topixel(x11,x22) = x23
  mov x22, x2
  bl topixel
  stur w10, [x23]
  add x2, x2, 1
  b lp


notvert:
  subs x5, x3, x1  // x5 = dx = (x2 - x1)  
  sub x6, x4, x2  // x6 = dy = (y2 - y1)
  // Si dx es negativo entonces el proceso es distinto
  b.mi negativedx

  //Aqui es con dy positivo
  subs x7, x6, x5 // x7 = p = dy-dx
  lsl x7, x7, 1   // p = 2 * (dy-dx)
  

loop:
  cmp x1, x3     // while(x1 < x2)
  b.hs end       // x1 >= x2 => end

  // Pinto las coordenadas x1,x2 es decir x1, y1
  mov x11, x1   //topixel(x11,x22) = x23
  mov x22, x2
  bl topixel
  stur w10, [x23]

  // if (p>=0) 
  cmp x7, xzr
  b.lt else
  add x2, x2, 1      //y1++
  lsl x8, x5, 1    //x8 = 2*dx
  subs x7, x7, x8  // p=p-2*dx
else:
  cmp x7, xzr
  b.ge endif 
  lsl x9, x6, 1   //x9 = 2*dy
  adds x7, x7, x9  // p=p+2*dy
  add x1, x1, 1  //x1++
endif:
  b loop 


// Salto a end si dy era positivo
  cmp x5, xzr
  b.gt end

negativedx:
loop1:
  cmp x1, x3     // while(x1 > x2)
  b.le end       // x1 <= x2 => end

  // Pinto las coordenadas x1,x2 es decir x1, y1
  mov x11, x1   //topixel(x11,x22) = x23
  mov x22, x2
  bl topixel
  stur w10, [x23]

  // if (p>=0) 
  cmp x7, xzr
  b.lt else1
  add x2, x2, 1      //y1++
  lsl x8, x5, 1    //x8 = 2*dx
  adds x7, x7, x8  // p=p+2*dx
else1:
  cmp x7, xzr
  b.ge endif1
  lsl x9, x6, 1   //x9 = 2*dy
  adds x7, x7, x9  // p=p+2*dy
  subs x1, x1, 1  //x1--
endif1:
  b loop1 


 end:  
  ldur x12, [sp, 72]
  ldur x11, [sp, 64]
  ldur x9, [sp, 56]
  ldur x8, [sp, 48]
  ldur x7, [sp, 40]
  ldur x6, [sp, 32]
  ldur x5, [sp, 24]
  ldur x2, [sp, 16]
  ldur x1, [sp, 8]
  ldur lr, [sp, 0]
  add sp, sp, 80
	br lr
	

