.ifndef datos_s
.equ datos_s, 0 

.data
//Suelo y cielo
.equ alturaSuelo, 160
.equ alturaArbol, 320
.equ anchoArbol, 30
.equ alturaArbusto, 120
.equ anchoArbusto, 50
.equ alturaNube, 120
.equ anchoNube, 40 

.equ anchoPiso, 250

.equ alturaCavernicola, 160


//Colores:


degradado_r1: .word 0x010000
degradado_g1: .word 0x000100
degradado_b1: .word 0x000001
no_degradado: .word 0x000000


//entorno: 
colorArbusto: .word 0x6ead6a //verde claro
colorArbustoBorde: .word 0x51854d //verde oscuro 


colorTierraFondo: .word 0x653830 //marron oscuro
colorTierraMedio: .word 0x7c3b1a //marron claro


//personajes 
colorPeloCavernicola: .word 0x66280a // marron oscuro 
colorPielCavernicola: .word 0xe6b8b //color crema 
colorRopaCavernicola: .word 0xff8000 //naranja 


colorRopaNinja: .word 0xff0000 //rojo
colorRopaNinja2: .word 0xe0e0e0 //gris

//fondo

colorCielo: .word 0x66ffff//celeste clarito
colorCielo2: .word 0x3399ff //celeste
colorCielo3: .word 0x0080ff //celeste oscuro
colorCielo4: .word 0x008bab //celeste oscuro


colorNubes: .word 0xffffff //blanco
colorNubes2: .word 0xe0e0e0 //gris 

colorSol: .word 0xffff00 //amarillo 

.endif
