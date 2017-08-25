
/*
	lightup LED with register
  */
#include "stm32f4xx.h" 
int t=100000;
void delay(int a);

/**
  *   main function
  */
int main(void)
{	
	
	/*turn on clock, when turning on io, clock needs to be turn on*/
	RCC_AHB1ENR |= (1<<3);	//to turn on GPIO D, need bit 3 to be 1
	
	/* LED initilization */
	
	/*GPIOD MODER12 cleardevice*/
	GPIOD_MODER  &= ~( 0x03<< (2*12));	
	/*PD12 MODER12 = 01b output mode*/
	GPIOD_MODER |= (1<<2*12);
	
	/*GPIOD OTYPER12 claer*/
	GPIOD_OTYPER &= ~(1<<1*12);
	/*PD12 OTYPER12 = 0b push mode*/
	GPIOD_OTYPER |= (0<<1*12);
	
	/*GPIOD OSPEEDR12 cleardevice*/
	GPIOD_OSPEEDR &= ~(0x03<<2*12);
	/*PD12 OSPEEDR12 = 0b speed 2MHz*/
	GPIOD_OSPEEDR |= (0<<2*12);
	
	/*GPIOD PUPDR12 cleardevice*/
	GPIOD_PUPDR &= ~(0x03<<2*12);
	/*PD12 PUPDR12 = 01b pull mode*/
	GPIOD_PUPDR |= (1<<2*12);
	
	/*PD12 BSRR register BS12 set as 1, let io output HIGH*/
	//GPIOD_BSRR |= (1<<12);
	
	/*PD12 BSRR register BR12 set as 1, let io output LOW */
	//GPIOD_BSRR |= (1<<12<<16);
	
	

	while(1)
	{
	/*PD12 BSRR register BR12 set as 1, let io output LOW */
	GPIOD_BSRR |= (1<<12<<16);
	
		delay(t);
	/*PD12 BSRR register BS12 set as 1, let io output HIGH*/
	GPIOD_BSRR |= (1<<12);
		
		delay(t);
	}
	

}

// function null, to let compiler compile without error
void SystemInit(void)
{	
}


void delay(int a)
{
	volatile int i,j;

    for (i=0 ; i < a ; i++)
    {
        j++;
    }

    return;
}





/*********************************************END OF FILE**********************/

