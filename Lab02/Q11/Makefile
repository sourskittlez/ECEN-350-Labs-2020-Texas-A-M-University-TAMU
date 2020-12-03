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
	
lab02d.o: lab02d.S
	$(CC) $(FLAGS) -c $^ -o $@

$(TARGET): main.o lab02d.o
	$(LD) main.o lab02d.o -o $@
