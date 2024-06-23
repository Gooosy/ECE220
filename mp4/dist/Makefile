ALL: swimmeet

GCC := gcc
FLAGS := -g -Wall
HEADERS := mp4.h
SOURCES := mp4main.o mp4.o


%.o: %.c ${HEADERS}
	${GCC} ${FLAGS} -c -o $@ $<

swimmeet: ${SOURCES}
	${GCC} ${FLAGS} -o $@ ${SOURCES}

clean::
	rm -f ${SOURCES}

clear: clean
	rm -f swimmeet
