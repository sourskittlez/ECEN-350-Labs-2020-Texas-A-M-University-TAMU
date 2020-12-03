TARGET = Lab01
CC = gcc
LD = gcc

FLAGS = -g -O0

all: $(TARGET)

clean:
	rm *.o
	rm $(TARGET)

main.o: main.c
	$(CC) $(FLAGS) -c $^  -o $@

test.o: test.S
	$(CC) $(FLAGS) -c $^ -o $@

$(TARGET): main.o test.o
	$(LD) main.o test.o -o $@
