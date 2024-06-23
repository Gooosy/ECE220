CC=gcc
CFLAGS=-g -Wall

HEADERS=mp6.h Makefile imageData.h lodepng.h
OBJECTS=mp6main.o lodepng.o imageData.o mp6.o

all: mp6

mp6: ${OBJECTS}
	${CC} ${CFLAGS} ${OBJECTS} -o mp6

%.o: %.c ${HEADERS}
	${CC} -c ${CFLAGS} $< -o $@

clean::
	rm -f *.o *~

clear: clean
	rm -f mp6
