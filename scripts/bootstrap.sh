#!/bin/sh

LIST=$1

#We really need to upgrade baselayout now that it's possible:
myBASELAYOUT=`grep "sys-apps/baselayout" $1`
myPORTAGE=`grep "sys-apps/portage" $1`
myGETTEXT=`grep "sys-devel/gettext" $1`
myBINUTILS=`grep "sys-devel/binutils" $1`
myGCC=`grep "sys-devel/gcc" $1`
myGLIBC=`grep "sys-libs/glibc" $1`
myTEXINFO=`grep "sys-apps/texinfo" $1`

echo "Using $myBASELAYOUT"
echo "Using $myPORTAGE"
echo "Using $myBINUTILS"
echo "Using $myGCC"
echo "Using $myGETTEXT"
echo "Using $myGLIBC"

cleanup() {
	cp /etc/make.conf.build /etc/make.conf
	exit $1
}

#USE may be set from the environment so we back it up for later.
if [ "${USE-UNSET}" = "UNSET" ]
then
	use_unset=yes
else
	use_old="$USE"
	use_unset=no
fi
export USE="build"

#get correct CFLAGS, CHOST, CXXFLAGS, MAKEOPTS since make.conf will be
#overwritten
cp /etc/make.conf /etc/make.conf.build
export CFLAGS="`spython -c 'import portage; print portage.settings["CFLAGS"];'`"
export CHOST="`spython -c 'import portage; print portage.settings["CHOST"];'`"
export CXXFLAGS="`spython -c 'import portage; print portage.settings["CXXFLAGS"];'`"
export MAKEOPTS="`spython -c 'import portage; print portage.settings["MAKEOPTS"];'`"

export CONFIG_PROTECT=""
#above allows portage to overwrite stuff
cd /usr/portage
emerge $myPORTAGE #separate, so that the next command uses the *new* emerge
emerge $myBASELAYOUT $myBINUTILS $myGCC $myGETTEXT || cleanup 1
if [ "$use_unset" = "yes" ]
then
	unset USE
else
	export USE="$use_old"
fi
# This line should no longer be required
#export USE="`spython -c 'import portage; print portage.settings["USE"];'` bootstrap"
emerge $myGLIBC $myGETTEXT $myBINUTILS $myGCC $myTEXINFO || cleanup 1
#restore settings
cleanup 0
