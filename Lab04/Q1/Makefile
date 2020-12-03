TARGET = Lab04

CC = gcc
LD = gcc

FLAGS = -g -O0

all: $(TARGET)

clean:
	rm *.o
	rm $(TARGET)

main.o: main.c
	$(CC) $(FLAGS) -c $^ -o $@

my_mul.o: my_mul.S
	$(CC) $(FLAGS) -c $^ -o $@
	
$(TARGET): main.o my_mul.o
	$(LD) main.o my_mul.o -o $@
