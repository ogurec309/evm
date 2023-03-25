.include "m328pdef.inc";1
ldi r16, 0x04 ;2
out sph, r16 ;3
ldi r16, 0x5f ;4
out spl, r6 ;5
m: call pp1 ;6
	jmp m ;9
pp1:
ldi xh, 01 ;10
ldi yh, 01; ;11
ldi xl, 0x00 ;13 
ldi yl, 0x00 ;14
ldi xh, 01 ;10
ldi xl, 0x00 ;13 ////////////
ldi r18, 60//30*2байта 

m1:
inc r19
inc r19
ldi xl, 0x00 
ldi yl, 0x00 
inc r28
inc r28//адрес элем
dec r18
dec r18

m3:
ld r20, x
inc r26
ld r24, x
ld r21, y
inc r28
ld r25, y

cp r21, r20
BRSH m5

mov r22, r20
mov r20, r21
mov r21, r22
dec r26
st x, r20
inc r26
st x, r24
dec r28
st y, r21
inc r28
st y, r25

m5:
inc r26

inc r28

cp r19, r18
breq m2

cp r26, r18
BRNE m3

rjmp m1

m2:
ldi xl, 0x1//1c
ld r20, x+//старший
ld r24, x+//младщий
ld r21, x+//старший
ld r25, x+//младщий
add r20, r21//старший байт
adc r24, r25//младший байт
LSR r24// делим на 2
ASR r20// делим на 2 сохраняя знак
BRCC m7//если НЕ 0 в переносе то
SUBI r24, -0x80 //+ 1 в 7 бит младщего байта
m7:
jmp m7
ret
