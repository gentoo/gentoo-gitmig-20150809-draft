#!/bin/sh

LIST=$1

myGETTEXT=`grep "sys-devel/gettext" $1`
myBINUTILS=`grep "sys-devel/binutils" $1`
myGCC=`grep "sys-devel/gcc" $1`
myGLIBC=`grep "sys-libs/glibc" $1`

echo "Using BINUTILS $myBINUTILS"
echo "Using GCC $myGCC"
echo "Using GETTEXT $myGETTEXT"
echo "Using GLIBC $myGLIBC"

export USE="build"
export STEPS="clean unpack compile install qmerge clean" 
cd /usr/portage
ebuild $myBINUTILS $STEPS || exit
ebuild $myGCC $STEPS || exit
ebuild $myGETTEXT $STEPS || exit
unset USE
export USE="`python -c 'import portage; print portage.settings["USE"];'` bootstrap"
ebuild $myGLIBC $STEPS || exit
ebuild $myGETTEXT $STEPS || exit
ebuild $myBINUTILS $STEPS || exit
ebuild $myGCC $STEPS || exit
unset USE
