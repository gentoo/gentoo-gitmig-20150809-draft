CC ?= gcc
CFLAGS ?= -pipe
RM ?= rm
INSTALL ?= install

prefix ?= /usr
libexecdir ?= ${prefix}/libexec
mandir ?= ${prefix}/share/man
infodir ?= ${prefix}/share/info


PRODUCTS = lockspool # mail.local

all: ${PRODUCTS}

clean:
	${RM} -f ${PRODUCTS} *.o

mail.local: mail.local.o locking.o open_with_exlock.o
	${CC} ${CFLAGS} -o $@ $^

lockspool: lockspool.o locking.o open_with_exlock.o
	${CC} ${CFLAGS} -o $@ $^

.c.o:
	${CC} ${CFLAGS} -c -o $@ $^

install: all
	${INSTALL} -m 0755 -g 0 -o 0 -d ${libexecdir}
	${INSTALL} -m 0755 -g 0 -o 0 -d ${mandir}/man1
	${INSTALL} -m 4555 -g 0 -o 0 lockspool ${libexecdir}/lockspool
	${INSTALL} -m 0444 -g 0 -o 0 lockspool.1 ${mandir}/man1
#	${INSTALL} -m 0555 -g 0 -o 0 mail.local ${libexecdir}/mail.local
	

