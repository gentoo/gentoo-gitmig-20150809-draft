#!/bin/bash
SRCS="glut_8x13	
glut_9x15 
glut_bitmap 
glut_bwidth 
glut_cindex 
glut_cmap 
glut_cursor 
glut_dials
glut_dstr
glut_event
glut_ext
glut_fullscrn
glut_gamemode
glut_get
glut_glxext
glut_hel10
glut_hel12
glut_hel18
glut_init
glut_input
glut_joy
glut_key
glut_keyctrl
glut_keyup
glut_menu
glut_menu2
glut_modifier
glut_mroman
glut_overlay
glut_roman
glut_shapes
glut_space
glut_stroke
glut_swap
glut_swidth
glut_tablet
glut_teapot
glut_tr10
glut_tr24
glut_util
glut_win
glut_winmisc
layerutil
glut_mesa
glut_warp
glut_vidresize"

for x in $SRCS
do
	echo "Compiling ${x}.c"
	gcc -c ${CFLAGS} -ansi -fPIC   -I../../include -I../.. -I/usr/X11R6/include  -Dlinux -D__i386__ -D_POSIX_SOURCE -D_BSD_SOURCE -D_GNU_SOURCE -DX_LOCALE  -DFUNCPROTO=15 -DNARROWPROTO ${x}.c   
done

objs=""
for x in $SRCS
do
	objs="${objs} ${x}.o"
done
echo "Linking GLUT library"
gcc -shared -Wl,-soname,libglut.so.3 -L/usr/X11R6/lib -lXi -lXext -lXmu -lXt -lX11 -o libglut.so.3.7 ${objs}      
