#include <avr/io.h>
#include <avr/interrupt.h>

int i = 1;
int ch;
int Mess[5];

ISR (USART_RX_vect)
{
	ch = UDR0;
	i = 1;
	if ((ch != '.') && (ch != ',') && (ch != '!'))
	{
		Mess[i] = ch;
		i++;
	}
	else if (ch == '.')
	{
		UDR0 = Mess[2];
		i = 1;
	}
}

ISR (USART_TX_vect)
{
	if (i==1){
		UDR0 = Mess[1];
		i++;
	}
	else if (i==2){
		UDR0 = Mess[4];
		i++;
	}
	else if (i==3){
		UDR0 = Mess[3];
		i++;
	}
}

int main(void)
{
	UBRR0 = 103;
	UCSR0B = (1<<TXCIE0)|(1<<TXEN0)|(1<<RXCIE0)|(1<<RXEN0);
	UCSR0C = (1<<UCSZ01)|(1<<UCSZ00);
	sei();
	while(1)
	{
	}
}