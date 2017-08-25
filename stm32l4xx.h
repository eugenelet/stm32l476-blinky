
/*onchip base address  */
#define PERIPH_BASE           ((unsigned int)0x40000000)                          

/*main line base address */
#define AHB1PERIPH_BASE       (PERIPH_BASE + 0x00020000)	

/*GPIO base address**/
//#define GPIOD_BASE            (AHB1PERIPH_BASE + 0x1C00)
#define GPIOD_BASE            (AHB1PERIPH_BASE + 0x0C00)


/* GPIOD register address, convert to pointer */
#define GPIOD_MODER				*(unsigned int*)(GPIOD_BASE+0x00)
#define GPIOD_OTYPER			*(unsigned int*)(GPIOD_BASE+0x04)
#define GPIOD_OSPEEDR			*(unsigned int*)(GPIOD_BASE+0x08)
#define GPIOD_PUPDR				*(unsigned int*)(GPIOD_BASE+0x0C)
#define GPIOD_IDR					*(unsigned int*)(GPIOD_BASE+0x10)
#define GPIOD_ODR					*(unsigned int*)(GPIOD_BASE+0x14)
#define GPIOD_BSRR					*(unsigned int*)(GPIOD_BASE+0x18)
#define GPIOD_LCKR					*(unsigned int*)(GPIOD_BASE+0x1C)
#define GPIOD_AFRL					*(unsigned int*)(GPIOD_BASE+0x20)
#define GPIOD_AFRH					*(unsigned int*)(GPIOD_BASE+0x24)

/*RCC base address*/
#define RCC_BASE              (AHB1PERIPH_BASE + 0x3800)

/*RCC's AHB1 clock can convert register address to pointer*/
#define RCC_AHB1ENR				*(unsigned int*)(RCC_BASE+0x30)
	

