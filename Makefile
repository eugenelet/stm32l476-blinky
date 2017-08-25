#Output files
PROJECT=blinky
EXECUTABLE=$(PROJECT).elf
BIN_IMAGE=$(PROJECT).bin
HEX_IMAGE = $(PROJECT).hex
#============================================================================#
HOST_CC=gcc
#Cross Compiler
CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy
GDB=arm-none-eabi-gdb
LD=arm-none-eabi-gcc

#============================================================================#

CFLAGS_INCLUDE=-I.

CFLAGS_DEFINE= \
	-D USE_STDPERIPH_DRIVER \
	-D STM32F429_439xx \
	-D __FPU_PRESENT=1 \
	-D ARM_MATH_CM4 \
	-D __FPU_USED=1 \
	-U printf -D printf=printf_base

		#__CC_ARM
CFLAGS_OPTIMIZE= \
	-O2
CFLAGS_NEW_LIB_NANO= \
	--specs=nano.specs --specs=nosys.specs  -u _printf_float
CFLAGS_WARNING= \
	-Wall \
	-Wextra \
	-Wdouble-promotion \
	-Wshadow \
	-Werror=array-bounds \
	-Wfatal-errors \
	-Wmissing-prototypes \
	-Wbad-function-cast  \
	-Wstrict-prototypes \
	-Wmissing-parameter-type

ARCH_FLAGS=-mlittle-endian -mthumb -mcpu=cortex-m4 \
	-mfpu=fpv4-sp-d16 -mfloat-abi=hard

CFLAGS=-g $(ARCH_FLAGS)\
	${CFLAGS_INCLUDE} ${CFLAGS_DEFINE} \
	${CFLAGS_WARNING}


LDFLAGS +=$(CFLAGS_NEW_LIB_NANO) --static -Wl,--gc-sections

LDFLAGS +=-T stm32f429zi_flash.ld
LDLIBS +=-Wl,--start-group -lm -Wl,--end-group

#============================================================================#

STARTUP=./startup_stm32f429_439xx.o

OBJS= ./blink.o \
	$(STARTUP) 
	   
#Make all
all:$(BIN_IMAGE)

$(BIN_IMAGE):$(EXECUTABLE)
	@$(OBJCOPY) -O binary $^ $@
	@echo 'OBJCOPY $(BIN_IMAGE)'

$(EXECUTABLE): $(OBJS)
	@$(LD) $(LDFLAGS) $(ARCH_FLAGS) $(OBJS) $(LDLIBS) -o $@ 
	@echo 'LD $(EXECUTABLE)'

%.o: %.c
	@$(CC) $(CFLAGS) -c $< -o $@
	@echo 'CC $<'

%.o: %.s
	@$(CC) $(CFLAGS) -c $< -o $@
	@echo 'CC $<'

PC_SIM:$(TEST_EXE)

$(TEST_EXE):$(HOST_SRC)
	$(HOST_CC) $(HOST_CFLAG) $^ -o $@
#Make clean
clean:
	rm -rf $(STARTUP_OBJ)
	rm -rf $(EXECUTABLE)
	rm -rf $(BIN_IMAGE)
	rm -f $(OBJS)

#Make flash
#flash:
#   st-flash write $(BIN_IMAGE) 0x8000000

#Make openocd
#openocd: flash
#   openocd -f ../debug/openocd.cfg

#Make cgdb
cgdb:
	cgdb -d $(GDB) -x ./st_util_init.gdb

#Make gdbtui
gdbtui:
	$(GDB) -tui -x ../st_util_init.gdb
#Make gdbauto
gdbauto: cgdb

#flash_bmp:
#   $(GDB) firmware.elf -x ./gdb_black_magic.gdb
cgdb_bmp: 
	cgdb -d $(GDB) firmware.elf -x ./bmp_gdbinit.gdb
	#-c "transport select hla_swd" 
flash_openocd:
	openocd -f interface/cmsis-dap.cfg \
	-f target/stm32f4x.cfg \
	-c "init" \
	-c "reset init" \
	-c "halt" \
	-c "flash write_image erase $(PROJECT).elf" \
	-c "verify_image $(PROJECT).elf" \
	-c "reset run" #-c shutdown
#automatically formate
astyle: 
	astyle -r --exclude=lib  *.c *.h
#============================================================================#

.PHONY:all clean flash_openocd openocd gdbauto gdbtui cgdb astyle
