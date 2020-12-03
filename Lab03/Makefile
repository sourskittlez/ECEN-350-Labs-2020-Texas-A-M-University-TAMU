TARGET = Lab03
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
	
lab03b.o: lab03b.S
	$(CC) $(FLAGS) -c $^ -o $@
	
lab03c.o: lab03c.S
	$(CC) $(FLAGS) -c $^ -o $@

$(TARGET): main.o test.o lab03b.o lab03c.o
	$(LD) main.o test.o lab03b.o lab03c.o -o $@
