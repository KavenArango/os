main.bin:main.asm Functions/printf.asm Functions/readDisk.asm Functions/printh.asm
	nasm -fbin main.asm -o main.bin

os:
	truncate main.bin -s 1200k
	mkisofs -o os.iso -b main.bin ./

clean:
	rm main.bin

run:
	qemu-system-x86_64 main.bin