#!/bin/sh

LIST=$1

myPORTAGE=`grep "sys-apps/portage" $1`
myGETTEXT=`grep "sys-devel/gettext" $1`
myBINUTILS=`grep "sys-devel/binutils" $1`
myGCC=`grep "sys-devel/gcc" $1`
myGLIBC=`grep "sys-libs/glibc" $1`

echo "Using PORTAGE $myPORTAGE"
echo "Using BINUTILS $myBINUTILS"
echo "Using GCC $myGCC"
echo "Using GETTEXT $myGETTEXT"
echo "Using GLIBC $myGLIBC"

export USE="build"
cd /usr/portage
emerge $myPORTAGE || exit
emerge $myGETTEXT || exit
emerge $myBINUTILS || exit
emerge $myGCC || exit
unset USE
export USE="`spython -c 'import portage; print portage.settings["USE"];'` bootstrap"
emerge $myGLIBC || exit
emerge $myGETTEXT || exit
emerge $myBINUTILS || exit
emerge $myGCC || exit
unset USE
