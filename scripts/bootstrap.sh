#!/bin/sh
MYPROFILE=default-1.0_rc6

#We really need to upgrade baselayout now that it's possible:
myBASELAYOUT=`cat /usr/portage/profiles/${MYPROFILE}/packages | grep -v '^#' | grep sys-apps/baselayout | sed 's:^\*::'`
myPORTAGE=`cat /usr/portage/profiles/${MYPROFILE}/packages | grep -v '^#' | grep sys-apps/portage | sed 's:^\*::'`
myGETTEXT=`cat /usr/portage/profiles/${MYPROFILE}/packages | grep -v '^#' | grep sys-devel/gettext | sed 's:^\*::'`
myBINUTILS=`cat /usr/portage/profiles/${MYPROFILE}/packages | grep -v '^#' | grep sys-devel/binutils | sed 's:^\*::'`
myGCC=`cat /usr/portage/profiles/${MYPROFILE}/packages | grep -v '^#' | grep sys-devel/gcc | sed 's:^\*::'`
myGLIBC=`cat /usr/portage/profiles/${MYPROFILE}/packages | grep -v '^#' | grep sys-libs/glibc | sed 's:^\*::'`

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
export ORIGUSE="`spython -c 'import portage; print portage.settings["USE"];'`"
export USE="build"
#get correct CFLAGS, CHOST, CXXFLAGS, MAKEOPTS since make.conf will be
#overwritten
cp /etc/make.conf /etc/make.conf.build
export CFLAGS="`spython -c 'import portage; print portage.settings["CFLAGS"];'`"
export CHOST="`spython -c 'import portage; print portage.settings["CHOST"];'`"
export CXXFLAGS="`spython -c 'import portage; print portage.settings["CXXFLAGS"];'`"
export MAKEOPTS="`spython -c 'import portage; print portage.settings["MAKEOPTS"];'`"
PROXY="`spython -c 'import portage; print portage.settings["PROXY"];'`"
if [ -n "${PROXY}" ] 
then
	echo "exporting PROXY=${PROXY}"
	export PROXY
fi
HTTP_PROXY="`spython -c 'import portage; print portage.settings["HTTP_PROXY"];'`"
if [ -n "${HTTP_PROXY}" ] 
then
	echo "exporting HTTP_PROXY=${HTTP_PROXY}"
	export HTTP_PROXY
fi
FTP_PROXY="`spython -c 'import portage; print portage.settings["FTP_PROXY"];'`"
if [ -n "${FTP_PROXY}" ] 
then
	echo "exporting FTP_PROXY=${FTP_PROXY}"
	export FTP_PROXY
fi

export CONFIG_PROTECT=""
#above allows portage to overwrite stuff
cd /usr/portage
emerge $myPORTAGE #separate, so that the next command uses the *new* emerge
emerge $myBASELAYOUT $myGETTEXT $myBINUTILS $myGCC || cleanup 1
#make.conf has been overwritten, so we explicitly export our original settings
export USE="$ORIGUSE"
emerge $myGLIBC $myBASELAYOUT $myGETTEXT $myBINUTILS $myGCC || cleanup 1
#restore original make.conf
cleanup 0
