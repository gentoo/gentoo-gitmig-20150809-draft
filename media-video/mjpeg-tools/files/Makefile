# Makefile for lavtools

M_OBJS       = lavrec lavplay movtar_play

LIBS= mjpeg/libmjpeg.a quicktime/quicktime/libquicktime.a 
LIBS_AND_OPT= $(LIBS) -lpng -lz -ljpeg

# uncomment if you want to use ALSA, 
# the Advanced Linux Sound Architecture (http://alsa.jcu.cz) 
#USE_ALSA = -DUSE_ALSA -lasound

#this is for software MJPEG playback, and GLib is used by movtarlib
L_FLAGS = -lpthread -lSDL -lglib

CFLAGS =  -O2 -I/usr/include/glib-1.2 -I/usr/lib/glib/include -I . -I buz -I quicktime/quicktime -I mjpeg -I movtar 

all:		lavrec lavplay lavvideo

#the dependence files are those which have been adapted to MMX and therefore
#are suspect to change 
./jpeg-6b-mmx/libjpeg.a: ./jpeg-6b-mmx/jdapimin.c ./jpeg-6b-mmx/jdmerge.c \
	./jpeg-6b-mmx/jidctfst.c ./jpeg-6b-mmx/jidctint.c \
	./jpeg-6b-mmx/jdcolor.c ./jpeg-6b-mmx/jdsample.c
	cd jpeg-6b-mmx; make

./quicktime/quicktime/libquicktime.a: 
	cd quicktime/quicktime; make

./mjpeg/libmjpeg.a: mjpeg/mjpeg.c mjpeg/mjpeg.h mjpeg/jpeg_dec.c
	cd mjpeg; make

./movtar/libmovtar.a: movtar/movtar.c movtar/movtar.h 
	cd movtar; make libmovtar.a

lavrec:		lavrec.o avilib.o audiolib.o lav_io.o movtar/movtar.c $(LIBS)
		gcc $(CFLAGS) -o lavrec lavrec.o avilib.o audiolib.o lav_io.o \
		$(LIBS_AND_OPT) $(L_FLAGS) 

lavplay:	lavplay.c avilib.o audiolib.o lav_io.o editlist.o $(LIBS)
		gcc -o lavplay lavplay.c avilib.o audiolib.o lav_io.o \
		editlist.o $(LIBS_AND_OPT) $(L_FLAGS) $(CFLAGS)

movtar_play: movtar/libmovtar.a movtar_play.c
	gcc movtar_play.c movtar/libmovtar.a \
	$(CFLAGS) $(L_FLAGS) -o movtar_play

lavvideo: lavvideo.c 
	gcc $(CFLAGS) lavvideo.c -o lavvideo

v4l-conf.o: v4l-conf.c
	gcc -g -g -O2 -c v4l-conf.c -o v4l-conf.o

v4l-conf: v4l-conf.o
	gcc -g -g -O2 -o v4l-conf v4l-conf.o -L/usr/X11R6/lib -lXxf86vm -lXxf86dga  -lXext -lX11 

install:
	su -c "cp -v $(M_OBJS) /usr/local/bin/"

clean:
		rm -f *.o lavplay lavrec movtar_play

realclean:
		rm -f *.o lavplay lavrec
		cd quicktime/quicktime; make clean
		cd jpeg-6b-mmx; make clean
		cd mjpeg; make clean
		cd movtar; make clean
#		cd utils; make clean
#		cd xlav; make clean
#		cd mpeg2enc; make clean
#		cd aenc; make clean













