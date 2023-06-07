.ifndef datos_s
.equ datos_s, 0 

.data
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
colorPeloCavernicola: .word 0x66280a // marron oscuro 
colorPielCavernicola: .word 0xe6b8bb //color crema 
colorRopaCavernicola: .word 0xff8000 //naranja 


colorRopaNinja: .word  0xff0000 //rojo
colorRopaNinja2: .word 0xe0e0e0 //gris

//fondo

colorCielo: .word  0x66ffff//celeste clarito
colorCielo2: .word 0x3399ff //celeste
colorCielo3: .word 0x0080ff //celeste oscuro
colorCielo4: .word 0x008bab //celeste oscuro


colorNubes: .word  0xffffff //blanco
colorNubes2: .word 0xe0e0e0 //gris 

colorSol1: .word 0xff8000 //naranja
colorSol2: .word 0xffee00 //amarillo



colorLuna1: .word 0xa0a0a9 //gris oscuro
colorLuna2: .word 0xe0e0e0 //gris 
colorCrater1: .word 0xa0a0a0 //gris + oscuro
colorCrater2: .word 0xd4d4d4 //negro
.endif
