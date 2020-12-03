TARGET = Lab05a
CC = gcc
LD = gcc

FLAGS = -g -O0

all: $(TARGET)

clean:
	rm *.o
	rm $(TARGET)

main.o: main.c
	$(CC) $(FLAGS) -c $^  -o $@
	
test2.o: test2.S
	$(CC) $(FLAGS) -c $^ -o $@

test.o: test.S
	$(CC) $(FLAGS) -c $^ -o $@
	
$(TARGET): main.o test.o test2.o
	$(LD) main.o test.o test2.o -o $@
