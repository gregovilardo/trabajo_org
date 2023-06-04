.ifndef graficos_s
.equ graficos_s, 0


/* pintarPixel:
    Parámetros:
        x0 = Dirección base del arreglo
        w1 = Color
        x2 = Coordenada en x
        x3 = Coordenada en y
    
    Si el pixel está dentro de la pantalla lo pinta, si no no hace nada. Usar está función en lugar de 
    pintar directamente para evitar escribir erróneamente.

    Utiliza x9
    No modifica ningún parámetro.
 */
pintarPixel:
        cmp x2, 640 // Veo si el x es valido
        b.hs return_pintarPixel
        cmp x3, 480 // Veo si el y es valido
        b.hs return_pintarPixel 
        mov x9, 640
        madd x9, x3, x9, x2 // x9 = (x3 * x9) + x2
        str w1, [x0, x9, lsl #2] // Guardo w1 en x0 + x9*2^2

    return_pintarPixel:
        br lr // return
//





/* pintarLineaHorizontal:
    Parámetros:
        x0 = Dirección base del arreglo
        w1 = Color
        x2 = Coordenada en x del comienzo de la linea
        x3 = Coordenada en y de la linea
        x4 = Coordenada en x del final de la linea

    Utiliza los registros usados por pintarPixel (x9).
    No modifica ningún parámetro.
 */

pintarLineaHorizontal:
        sub sp, sp, #16 // Guardo el puntero de retorno en el stack
        stur lr, [sp, #8]
        stur x2, [sp] // Guardo en el stack la coordenada en x del comienzo de la linea 

    loop_pintarLineaHorizontal:
        cmp x2, x4
        b.gt end_loop_pintarLineaHorizontal
        bl pintarPixel
        add x2, x2, #1
        b loop_pintarLineaHorizontal

    end_loop_pintarLineaHorizontal:
        ldur lr, [sp, #8] // Recupero el puntero de retorno del stack
        ldur x2, [sp] // Recupero la coordenada en x del comienzo de la linea
        add sp, sp, #16 

        br lr // return
//


/* pintarRectangulo:
    Parámetros:
        x0 = Dirección base del arreglo
        w1 = Color
        x2 = Coordenada inicial en x
        x3 = Coordenada inicial en y
        x4 = Coordenada final en x
        x5 = Coordenada final en y

    Utiliza los registros usados por pintarPixel (x9).
    No modifica ningún parámetro.
 */
pintarRectangulo:
        sub sp, sp, #16 
        stur lr, [sp, #8] // Guardo el puntero de retorno en el stack
        stur x3, [sp] // Guardo x3 en el stack

    loop_pintarRectangulo: // loop para avanzar en y
        cmp x3, x5
        b.gt end_loop_pintarRectangulo
        bl pintarLineaHorizontal
        add x3, x3, #1
        b loop_pintarRectangulo
    
    end_loop_pintarRectangulo:
        ldur lr, [sp, #8] // Recupero el puntero de retorno del stack
        ldur x3, [sp] // Recupero x3 del stack
        add sp, sp, #16

        br lr // return
//


/* pintarCirculo
    Parámetros:
        x0 = Dirección base del arreglo
        w1 = Color
        x2 = Coordenada del centro en x
        x3 = Coordenada del centro en y
        x4 = Radio

    Utiliza x9, x10, x11, x12, x13, x14, x15, x16 y los registros utilizados por pintarPixel (x9).
    No modifica ningún parámetro.
 */
/* Funciona recorriendo el cuadrado mínimo que contiene al círculo, y en cada pixel decidiendo si pintar o no.
    La forma usual de saber si un punto (x, y) está en el circulo centrado en (x1, y1) de radio r es
    ver si la norma de la distancia entre el punto y el centro es menor que r.
    En formulas:
        ||(x, y) - (x1, y1)|| <= r
    Aplicando la definición de norma:
        sqrt((x - x1)^2 + (y - y1)^2) <= r
    Esto es equivalente a:
        (x - x1)^2 + (y - y1)^2 <= r^2

    Para hacer menos cálculos uso esta última formula.
 */
pintarCirculo:
        sub sp, sp, #8 // Guardo el puntero de retorno en el stack
        stur lr, [sp]

        mov x15, x2 // Guardo en x15 la condenada del centro en x
        mov x16, x3 // Guardo en x16 la condenada del centro en y
        add x10, x2, x4 // Guardo en x10 la posición final en x
        add x11, x3, x4 // Guardo en x11 la posición final en y
        mul x12, x4, x4 // x12 = r^2 // para comparaciones en el loop
        sub x2, x2, x4 // Pongo en x2 la posición inicial en x

    loop0_pintarCirculo: // loop para avanzar en x
        cmp x2, x10
        b.gt end_loop0_pintarCirculo
        sub x3, x11, x4
        sub x3, x3, x4 // Pongo en x3 la posición inicial en y

    loop1_pintarCirculo: // loop para avanzar en y
        cmp x3, x11
        b.gt end_loop1_pintarCirculo // Veo si tengo que pintar el pixel actual
        sub x13, x2, x15 // x13 = distancia en x desde el pixel actual al centro
        smull x13, w13, w13 // x13 = w13 * w13 // Si los valores iniciales estaban en el rango permitido, x13 = w13 (sumll es producto signado)
        sub x14, x3, x16 // x14 = distancia en y desde el pixel actual al centro
        smaddl x13, w14, w14, x13 // x13 = x14*x14 + x13 // x13 = cuadrado de la distancia entre el centro y el pixel actual
        cmp x13, x12
        b.gt fi_pintarCirculo 
        bl pintarPixel // Pinto el pixel actual

    fi_pintarCirculo:
        add x3, x3, #1
        b loop1_pintarCirculo

    end_loop1_pintarCirculo:
        add x2, x2, #1
        b loop0_pintarCirculo

    end_loop0_pintarCirculo:
        mov x2, x15 // Restauro en x2 la condenada del centro en x
        mov x3, x16 // Restauro en x3 la condenada del centro en y
        ldur lr, [sp] // Recupero el puntero de retorno del stack
        add sp, sp, #8 

        br lr // return
//

// Dline:
// Pinta una linea diagonal, vertical u horizontal.
// posicion inicial (x2, x3) = (x1, y1)
// posicion final (x4, x5) = (x2, y2)


dline:

  sub sp, sp, 80
  stur x13, [sp, 72]
  stur x12, [sp, 64]
  stur x10, [sp, 56]
  stur x9, [sp, 48]
  stur x8, [sp, 40]
  stur x7, [sp, 32]
  stur x6, [sp, 24]
  stur x3, [sp, 16]
  stur x2, [sp, 8]
  stur lr, [sp, 0]
  // modificamos x2, x3, x6, x7, x8, x9, x10, x12, x23
  
  // posicion inicial (x2, x3) = (x1, y1)
  // posicion final (x4, x5) = (x2, y2)

  subs x6, x4, x2  // x6 = dx = (x2 - x1)  
  sub x7, x5, x3  // x7 = dy = (y2 - y1)
  // Si dx es negativo entonces el proceso es distinto
  b.mi negativedx

  //Aqui es con dy positivo
  subs x8, x7, x6 // x8 = p = dy-dx
  lsl x8, x8, 1   // p = 2 * (dy-dx)
  

  loop:
    cmp x2, x4     // while(x1 < x2)
    b.hs end       // x1 >= x2 => end
  
    // Pinto las coordenadas x1,x2 es decir x1, y1
    bl pintarPixel
  
    // if (p>=0) 
    cmp x8, xzr
    b.lt else
    add x3, x3, 1      //y1++
    lsl x9, x6, 1    //x9 = 2*dx
    subs x8, x8, x9  // p=p-2*dx
  else:
    cmp x8, xzr
    b.ge endif 
    lsl x10, x7, 1   //x10 = 2*dy
    adds x8, x8, x10  // p=p+2*dy
    add x2, x2, 1  //x1++
  endif:
    b loop 
  
  
  // Salto a end si dy era positivo
    cmp x6, xzr
    b.gt end
  
  negativedx:
    loop1:
      cmp x2, x4     // while(x1 > x2)
      b.le end       // x1 <= x2 => end
    
      // Pinto las coordenadas x2,x3 es decir x1, y1
      bl pintarPixel
    
      // if (p>=0) 
      cmp x8, xzr
      b.lt else1
      add x3, x3, 1      //y1++
      lsl x9, x6, 1    //x9 = 2*dx
      adds x8, x8, x9  // p=p+2*dx
    else1:
      cmp x8, xzr
      b.ge endif1
      lsl x10, x7, 1   //x10 = 2*dy
      adds x8, x8, x10  // p=p+2*dy
      subs x2, x2, 1  //x1--
    endif1:
      b loop1 
  
  
   end:  
    ldur x13, [sp, 72]
    ldur x12, [sp, 64]
    ldur x10, [sp, 56]
    ldur x9, [sp, 48]
    ldur x8, [sp, 40]
    ldur x7, [sp, 32]
    ldur x6, [sp, 24]
    ldur x3, [sp, 16]
    ldur x2, [sp, 8]
    ldur lr, [sp, 0]
    add sp, sp, 80
  	br lr
	
/* pintarTriangulo:
    Parámetros:
        x0 = Dirección base del arreglo
        w1 = Color
        x2 = Coordenada inicial en x
        x3 = Coordenada inicial en y
        x4 = Coordenada final en x
        x5 = Coordenada final en y

    Utiliza los registros usados por pintarPixel (x9).
    No modifica ningún parámetro.
 */

pintarTriangulo:
  sub sp, sp, #16 
  stur lr, [sp, #8] // Guardo el puntero de retorno en el stack
  stur x3, [sp] // Guardo x3 en el stack

  loop_pintarTriangulo: // loop para avanzar en y
    cmp x3, x5
    b.gt end_loop_pintarTriangulo
    bl dline
    add x3, x3, #1
    b loop_pintarTriangulo
  
  end_loop_pintarTriangulo:
    ldur lr, [sp, #8] // Recupero el puntero de retorno del stack
    ldur x3, [sp] // Recupero x3 del stack
    add sp, sp, #16

    br lr // return
//


/* circulos_horizontales
    Parámetros:
        x0 = Dirección base del arreglo
        w1 = Color
        x2 = Coordenada del centro en x
        x3 = Coordenada del centro en y
        x4 = Radio
        x5 = distancia entre circulos
        x6 = coordenada destino x

    Utiliza x9, x10, x11, x12, x13, x14, x15, x16 y los registros utilizados por pintarPixel (x9).
    No modifica ningún parámetro.
 */

circulos_horizontales:
  sub sp, sp, #16 
  stur lr, [sp, #8]   // Guardo el puntero de retorno en el stack
  stur x2, [sp]       // Guardo x3 en el stack

  loop_circulos_horizontales: // loop para avanzar en x
    cmp x2, x6
    b.gt end_loop_circulos_horizontales
    bl pintarCirculo
    add x2, x2, x5
    b loop_circulos_horizontales
  
  end_loop_circulos_horizontales:
    ldur lr, [sp, #8] // Recupero el puntero de retorno del stack
    ldur x2, [sp] // Recupero x3 del stack
    add sp, sp, #16

    br lr // return
//

/* circulos_verticales
    Parámetros:
        x0 = Dirección base del arreglo
        w1 = Color
        x2 = Coordenada del centro en x
        x3 = Coordenada del centro en y
        x4 = Radio
        x5 = distancia entre circulos
        x6 = coordenada destino y

    Utiliza x9, x10, x11, x12, x13, x14, x15, x16 y los registros utilizados por pintarPixel (x9).
    No modifica ningún parámetro.
 */

circulos_verticales:
  sub sp, sp, #16 
  stur lr, [sp, #8]   // Guardo el puntero de retorno en el stack
  stur x3, [sp]       // Guardo x3 en el stack

  loop_circulos_verticales: // loop para avanzar en x
    cmp x3, x6
    b.gt end_loop_circulos_verticales
    bl pintarCirculo
    add x3, x3, x5
    b loop_circulos_verticales
  
  end_loop_circulos_verticales:
    ldur lr, [sp, #8] // Recupero el puntero de retorno del stack
    ldur x3, [sp] // Recupero x3 del stack
    add sp, sp, #16

    br lr // return

forma_nube:
	movz x1, 0xff, lsl 16
	movk x1, 0xffff, lsl 00
  
    bl circulos_horizontales


.endif
