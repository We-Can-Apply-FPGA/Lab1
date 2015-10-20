all: compile flash
compile:
	quartus_sh --flow compile Lab1
flash:
	quartus_pgm -c "USB-Blaster" Chain.cdf
