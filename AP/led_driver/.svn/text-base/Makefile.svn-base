CROSS_COMPILE=
CC=$(CROSS_COMPILE)gcc

ifneq ($(KERNELRELEASE),)
	obj-m := led.o
else
	KERNELDIR ?= $(6410L_KERNEL_DIR)
	
	PWD := $(shell pwd)
	
default:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules
	
clean:
	rm -f *.o *.ko Module.symvers *.mod.c modules.order .*.cmd
	rm -fr .tmp*
endif 

