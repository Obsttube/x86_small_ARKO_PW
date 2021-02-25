CC=g++
ASMBIN=nasm

all : asm cc link
asm : 
	$(ASMBIN) -o excercise_7h.o -f elf -g -l excercise_7h.lst excercise_7h.asm
cc :
	$(CC) -m32 -c -g -O0 main.cpp &> errors.txt
link :
	$(CC) -m32 -g -o ex_7h main.o excercise_7h.o
clean :
	rm *.o
	rm ex_7h
	rm errors.txt
	rm excercise_7h.lst
