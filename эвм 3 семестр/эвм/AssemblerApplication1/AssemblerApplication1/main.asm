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
ldi r18, 60//30*2байта

m1:
inc r19
inc r19
ldi xl, 0x00
ldi yl, 0x00
inc r28
inc r28//адрес элем

m3:
 ld r20, x+
ld r21, x
dec r26

ld r22, y+
ld r23, y
dec r28

cp r20, r22 //сравниваем 2 сосдних элемента
BRLO m5 //сравниваем 2 сосдних элемента
cp r22, r20
BRNE m51
cp r23, r21
BRSH m5

// меняем местами 2 cоседних элемента
m51:
mov r24, r20 
mov r25, r21
mov r20, r22
mov r21, r23
mov r22, r24
mov r23, r25
st x+, r20
st x, r21
st y+, r22
st y, r23

m5:
inc r26
inc r28
cp r19, r18
breq m2

cp r26, r18
BRNE m3

rjmp m1

m2:
ldi xl, 0x1c//1c
ld r20, x+//старший
ld r21, x+//младщий
ld r22, x+//старший
ld r23, x+//младщий
add r20, r22//старший байт
adc r21, r23//младший байт
LSR r21// делим на 2
ASR r20// делим на 2 сохраняя знак
BRCC m7//если НЕ 0 в переносе то
SUBI r21, -0x80 //+ 1 в 7 бит младщего байта
m7:
jmp m7
ret