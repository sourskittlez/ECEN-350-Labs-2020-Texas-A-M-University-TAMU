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
	
lab04b.o: lab04b.S
	$(CC) $(FLAGS) -c $^ -o $@

$(TARGET): main.o lab04b.o
	$(LD) main.o lab04b.o -o $@
