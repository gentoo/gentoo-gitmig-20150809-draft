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

#USE may be set from the environment (recommended) so we back it up for later.
if [ "${USE-UNSET}" = "UNSET" ]
then
	unset=yes
else
	olduse="$USE"
	unset=no
fi
export USE="build"
export CONFIG_PROTECT=""
#above allows portage to overwrite stuff
cd /usr/portage
emerge $myPORTAGE || exit
emerge $myGETTEXT || exit
emerge $myBINUTILS || exit
emerge $myGCC || exit
if [ "$unset" = "yes" ]
then
	unset USE
else
	export USE="$olduse"
fi
export USE="`spython -c 'import portage; print portage.settings["USE"];'` bootstrap"
emerge $myGLIBC || exit
emerge $myGETTEXT || exit
emerge $myBINUTILS || exit
emerge $myGCC || exit
