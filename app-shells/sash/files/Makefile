#
# Makefile for sash
#
# The HAVE_GZIP definition adds the -gzip and -gunzip commands.
# The HAVE_EXT2 definition adds the -chattr and -lsattr comamnds.
#

CFLAGS = -m486 -march=i486 -O2 -Wall -Wmissing-prototypes -DHAVE_READLINE
#CFLAGS = -pipe -O2 -DHAVE_GZIP -DHAVE_EXT2 -DHAVE_READLINE
LDFLAGS = 
LIBS = -lreadline -lncurses


BINDIR = /bin
MANDIR = /usr/man/man1


OBJS = sash.o cmds.o utils.o


sash:	$(OBJS)
	$(CC) $(LDFLAGS) -o sash $(OBJS) $(LIBS)

clean:
	rm -f $(OBJS) sash

install: sash
	cp sash $(BINDIR)/sash
	cp sash.1 $(MANDIR)/sash.1

$(OBJS):	sash.h
