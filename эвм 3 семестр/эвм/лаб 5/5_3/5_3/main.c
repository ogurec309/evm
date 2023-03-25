 #include <avr/io.h>
 #include <avr/interrupt.h>
 char x, count, outt;
 ISR(PCINT0_vect)
 {
	 char h = (count & 0b10000000) >> 3;//Старший бит счетчика в 5 бит h
	 outt=PORTB&0xdf;//устанавливаем в 5 бит 0
	 outt|=h;//устанваливаем в 5 бит h
	 PORTB = outt;
 }
 ISR(PCINT2_vect)
 {
	 char h = (count & 0b10000000) >> 3;//Старший бит счетчика в 5 бит h
	 outt=PORTB&0xdf;//устанавливаем в 5 бит 0
	 outt|=h;//устанваливаем в 5 бит h
	 PORTB = outt;
 }

 int main(void)
 {
	 x=0;
	 DDRB = 0x20;//тк PB это светодиод и нам надо выводить его значение на логику
	 DDRD = 0x00;//чтение бита из порта PD3
	 DDRB |= 0x20;//поддтяжка вверх
	 DDRD |= 0x08;//поддтяжка вверх
	 PCICR = 0x05; //разрешение прерываний (разрешены группы прерываний 0 и 2 B и D)
	 //PCMSK0 = 0xFF;//разрешить всё
	 PCMSK0 = 0x20; //разрешено только PCINT0 (PB5)
	 //PCMSK2 = 0xFF;//разрешить всё
	 PCMSK2 = 0x08; //разрешено только PCINT2 (PD3)
	 sei();//разрешение прерываний
	 while (1)
	 {
		 PORTC = count;
		 count++;
	 }
 }