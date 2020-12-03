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
	
lab02c.o: lab02c.S
	$(CC) $(FLAGS) -c $^ -o $@

$(TARGET): main.o lab02c.o
	$(LD) main.o lab02c.o -o $@
