#!/bin/sh
MYPROFILEDIR=`readlink -f /etc/make.profile`
if [ ! -d $MYPROFILEDIR ]
then
	echo '!!! Error: '"$MYPROFILEDIR does not exist. Exiting."
	exit 1
fi
 
if [ -e /usr/bin/spython ]
then
	#1.0_rc6 and earlier
	PYTHON=/usr/bin/spython
else
	#1.0 and later
	PYTHON=/usr/bin/python
fi
#We really need to upgrade baselayout now that it's possible:
myBASELAYOUT=`cat ${MYPROFILEDIR}/packages | grep -v '^#' | grep sys-apps/baselayout | sed 's:^\*::'`
myPORTAGE=`cat ${MYPROFILEDIR}/packages | grep -v '^#' | grep sys-apps/portage | sed 's:^\*::'`
myGETTEXT=`cat ${MYPROFILEDIR}/packages | grep -v '^#' | grep sys-devel/gettext | sed 's:^\*::'`
myBINUTILS=`cat ${MYPROFILEDIR}/packages | grep -v '^#' | grep sys-devel/binutils | sed 's:^\*::'`
myGCC=`cat ${MYPROFILEDIR}/packages | grep -v '^#' | grep sys-devel/gcc | sed 's:^\*::'`
myGLIBC=`cat ${MYPROFILEDIR}/packages | grep -v '^#' | grep sys-libs/glibc | sed 's:^\*::'`
myTEXINFO=`cat ${MYPROFILEDIR}/packages|grep -v '^#'|grep sys-apps/texinfo |sed 's:^\*::'`

echo "Using $myBASELAYOUT"
echo "Using $myPORTAGE"
echo "Using $myBINUTILS"
echo "Using $myGCC"
echo "Using $myGETTEXT"
echo "Using $myGLIBC"
echo "Using $myTEXINFO"

#This should not be set to get glibc to build properly. See bug #7652.
LD_LIBRARY_PATH=""

cleanup() {
	cp /etc/make.conf.build /etc/make.conf
	exit $1
}

#USE may be set from the environment so we back it up for later.
export ORIGUSE="`$PYTHON -c 'import portage; print portage.settings["USE"];'`"
export GENTOO_MIRRORS="`$PYTHON -c 'import portage; print portage.settings["GENTOO_MIRRORS"];'`"
export USE="-* build bootstrap"
#get correct CFLAGS, CHOST, CXXFLAGS, MAKEOPTS since make.conf will be
#overwritten
cp /etc/make.conf /etc/make.conf.build
export CFLAGS="`$PYTHON -c 'import portage; print portage.settings["CFLAGS"];'`"
export CHOST="`$PYTHON -c 'import portage; print portage.settings["CHOST"];'`"
export CXXFLAGS="`$PYTHON -c 'import portage; print portage.settings["CXXFLAGS"];'`"
export MAKEOPTS="`$PYTHON -c 'import portage; print portage.settings["MAKEOPTS"];'`"
PROXY="`$PYTHON -c 'import portage; print portage.settings["PROXY"];'`"
if [ -n "${PROXY}" ] 
then
	echo "exporting PROXY=${PROXY}"
	export PROXY
fi
HTTP_PROXY="`$PYTHON -c 'import portage; print portage.settings["HTTP_PROXY"];'`"
if [ -n "${HTTP_PROXY}" ] 
then
	echo "exporting HTTP_PROXY=${HTTP_PROXY}"
	export HTTP_PROXY
fi
FTP_PROXY="`$PYTHON -c 'import portage; print portage.settings["FTP_PROXY"];'`"
if [ -n "${FTP_PROXY}" ] 
then
	echo "exporting FTP_PROXY=${FTP_PROXY}"
	export FTP_PROXY
fi

export CONFIG_PROTECT="-*"
# disable autoclean, or it b0rks
export AUTOCLEAN="no"
#above allows portage to overwrite stuff
cd /usr/portage
emerge $myPORTAGE #separate, so that the next command uses the *new* emerge
emerge $myBASELAYOUT $myTEXINFO $myGETTEXT $myBINUTILS $myGCC || cleanup 1
#make.conf has been overwritten, so we explicitly export our original settings
export USE="$ORIGUSE bootstrap"
emerge $myGLIBC $myBASELAYOUT $myTEXINFO $myGETTEXT $myBINUTILS $myGCC || cleanup 1
#restore original make.conf
cleanup 0
