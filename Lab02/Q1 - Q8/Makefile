TARGET = Lab02
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
	
lab02b.o: lab02b.S
	$(CC) $(FLAGS) -c $^ -o $@

$(TARGET): main.o test.o lab02b.o
	$(LD) main.o test.o lab02b.o -o $@
