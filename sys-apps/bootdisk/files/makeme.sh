#!/bin/sh
FILE=linuxrc5
rm linuxrc $FILE.o
gcc -o $FILE.o -c $FILE.c -I/usr/include/dietlibc && ld -static -o linuxrc $FILE.o /usr/lib/dietlibc.a
