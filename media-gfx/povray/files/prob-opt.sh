#!/bin/bash
# Script from Klaus-J. Wolf <yanestra@web.de>

# Please read through this script and understand it before using it.
# IF YOU DON'T UNDERSTAND IT, DON'T USE IT.
# There are a few things you'll probably want to change - pay attention.
# IMPORTANT: This will overwrite your Portage installation of POV-Ray.

# Notes from Klaus-J. Wolf in bug report #13400:
# "I have written a small script that does the lengthy work of
# probabilistical optimization of Povray (3.50c tested, with gcc-3.2.1). 
# In case of an Athlon/600 I got a performance improvement of about 272% 
# to the original settings (ICC gave slightly worse results), in case of 
# an P4/2000, I got less improvement, but still better than ICC.
# The script uses all scene files of the original distribution (expected to be
# unpacked in the current directory) to create probabilistic profiles. Then it
# uses the profiles to recompile the source."

# Change this:
NAME="Me"

PREFIX=/usr

cat <<EOF
Attention!
You need to:

1. Have the Povray sources unpacked in the (current) local directory.

2. Have the necessary library files installed in $PREFIX.
   (By typing "make install-data" in the povray dir.)

EOF
read -p "Press ENTER to continue. "
cd povray-3.50a || exit 9

INCLUDES="-I/usr/local/include -L/usr/local/lib -I/usr/X11R6/include -L/usr/X11R6/lib"
# Edit these to match your system:
MYCFLAGS="${INCLUDES} -Wno-multichar -O3 -ffast-math -march=i686 -mcpu=i686 -foptimize-sibling-calls -finline-functions -fexpensive-optimizations -funroll-loops -malign-double -minline-all-stringops -fomit-frame-pointer -mfpmath=sse -msse -msse2"

MYCXXFLAGS="${MYCFLAGS}"
PHASE1="-fprofile-arcs"
PHASE2="-fbranch-probabilities"

[ -f Makefile ] || ./configure --prefix=$PREFIX
for a in `find . -name Makefile`
do
  [ -f $a~ ] || mv $a $a~
  sed "s&^CFLAGS = .*&CFLAGS = $MYCFLAGS $PHASE1&1" <$a~ | \
  sed "s&^CXXFLAGS = .*&CXXFLAGS = $MYCXXFLAGS $PHASE1&1" |
  sed "s/^LIBS = \\(.*\\)/LIBS = \\1 -ljpeg -ltiff -lpng/1" >$a
done

AUTHFILE="src/optout.h"
[ -f ${AUTHFILE}~ ] || mv $AUTHFILE ${AUTHFILE}~
cat ${AUTHFILE}~ |grep -v '^#error' | \
  sed "s/FILL IN NAME HERE\\.*/${NAME}/1" \
  >$AUTHFILE

make

for a in `find scenes -name "*.pov"`
do
  src/povray +H200 +W320 +O`basename $a .pov`.png +I$a +QR -D -V
done

rm -f `find . -name "*.o" -type f`

for a in `find . -name Makefile`
do
  [ -f $a~ ] || mv $a $a~
  sed "s&^CFLAGS = .*&CFLAGS = $MYCFLAGS $PHASE2&1" <$a~ | \
  sed "s&^CXXFLAGS = .*&CXXFLAGS = $MYCXXFLAGS $PHASE2&1" |
  sed "s/^LIBS = \\(.*\\)/LIBS = \\1 -ljpeg -ltiff -lpng/1" >$a
done

make

