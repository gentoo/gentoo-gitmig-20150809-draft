#!/bin/bash
# Copyright 2005 The Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/scripts/bootstrap-darwin.sh,v 1.1 2005/02/12 01:50:04 kito Exp $

# Make sure sudo passwd is asked for
sudo true

trap 'exit 1' TERM KILL INT QUIT ABRT

# we only run on Darwin
if [ `uname` == "Darwin" ]; then
	:
else
	echo `uname`
	echo "You need to be running a mach kernel to proceed."
	exit 1
fi

## some vars

# We do not want stray $TMP, $TMPDIR or $TEMP settings
unset TMP TMPDIR TEMP
ARCH=ppc
CFLAGS="-O2 -pipe"
CHOST="powerpc-apple-darwin"
ROOT=""
PORTDIR=${ROOT}/usr/portage
DISTDIR=${PORTDIR}/distfiles
PORTAGE_TMPDIR=${ROOT}/var/tmp
PORTAGEURL="http://gentoo.twobit.net/portage"
PORTAGEVERSION=2.0.51.16
PYTHONVERSION=2.3.4
DMGURL="http://www.metadistribution.org/gentoo/macos"
DMGVERSION=20041118
BOOTSTRAPSCRIPT="`pwd`/${0##*/}"
echo ${BOOTSTRAPSCRIPT}

if [ -z "${CHOST}" ] ; then
	echo "Please set CHOST"
	exit 1
fi
if [ -z "${CFLAGS}" ] ; then
	echo "Please set CFLAGS"
	exit 1
fi
if [ -z "${ARCH}" ] ; then
	echo "Please set ARCH"
	exit 1
fi
export CXXFLAGS="${CXXFLAGS:-${CFLAGS}}"
export MAKEOPTS="${MAKEOPTS:--j2}"

# Source functions to have colors and nice output

if [ -e /etc/init.d/functions.sh ] ; then
	source /etc/init.d/functions.sh

	# Use our own custom script, else logger cause things to
	# 'freeze' if we do not have a system logger running
	esyslog() {
		echo &> /dev/null
	}
else
	eerror() { echo "!!! $*"; }
	einfo() { echo "* $*"; }
fi

## Functions Start Here

bootstrap_od() {

	## TODO
	echo "Not implemented yet."
	exit 1
	
}

bootstrap_portage()  {
	TARGET=$1

	if [ ! -x ${ROOT}/usr/bin/emerge ] ; then
		PV=${PORTAGEVERSION}
		A=portage-${PV}.tar.bz2

		if [ ! -e ${DISTDIR}/${A} ] ; then
			cd ${DISTDIR} && sudo curl -O ${PORTAGEURL}/${A}
		fi

		export S="${PORTAGE_TMPDIR}/portage-${PV}"

		rm -rf ${S}
		mkdir -p ${S}
		cd ${S}
		tar -jxvf ${DISTDIR}/${A}

		S=${S}/portage-${PV}
		cd ${S}

		cd ${S}/src ; gcc ${CFLAGS} tbz2tool.c -o tbz2tool
		cd ${S}/cnf
		[ -d ${TARGET}/etc ] || sudo mkdir -p ${TARGET}/etc
		cp make.globals.mac ${TARGET}/etc/make.globals
		cp make.conf ${TARGET}/etc/make.conf
		cp etc-update.conf dispatch-conf.conf ${TARGET}/etc/

		mkdir -p ${TARGET}/usr/lib/portage/pym
		cd ${S}/pym
		cp *.py ${TARGET}/usr/lib/portage/pym/

		mkdir -p ${TARGET}/usr/lib/portage/bin
		cd ${S}/bin
		cp * ${S}/src/tbz2tool ${TARGET}/usr/lib/portage/bin/
		
		[ -d ${TARGET}/usr/bin ] || sudo mkdir ${TARGET}/usr/bin
		[ -d ${TARGET}/usr/sbin ] || sudo mkdir ${TARGET}/usr/sbin
		[ -d ${TARGET}/var/lib/portage ] || sudo mkdir ${TARGET}/var/lib/portage
		cd ${TARGET}/usr/bin
		ln -sf ../lib/portage/bin/emerge ${TARGET}/usr/bin/emerge
		ln -sf ../lib/portage/bin/pkgmerge $TARGET/usr/sbin/pkgmerge
		ln -sf ../lib/portage/bin/ebuild ${TARGET}/usr/sbin/ebuild
		ln -sf ../lib/portage/bin/ebuild.sh ${TARGET}/usr/sbin/ebuild.sh

		ln -sf ../lib/portage/bin/etc-update ${TARGET}/usr/sbin/etc-update
		ln -sf ../lib/portage/bin/dispatch-conf ${TARGET}/usr/sbin/dispatch-conf
		ln -sf ../lib/portage/bin/archive-conf ${TARGET}/usr/sbin/archive-conf
		ln -sf ../lib/portage/bin/fixpackages ${TARGET}/usr/sbin/fixpackages

		ln -sf ../lib/portage/bin/env-update ${TARGET}/usr/sbin/env-update
		ln -sf ../lib/portage/bin/xpak ${TARGET}/usr/bin/xpak
		ln -sf ../lib/portage/bin/repoman ${TARGET}/usr/bin/repoman
		ln -sf ../lib/portage/bin/tbz2tool ${TARGET}/usr/bin/tbz2tool
		ln -sf ../lib/portage/bin/portageq ${TARGET}/usr/bin/portageq

		ln -sf ../lib/portage/bin/g-cpan.pl ${TARGET}/usr/bin/g-cpan.pl
		ln -sf ../lib/portage/bin/quickpkg ${TARGET}/usr/bin/quickpkg
		ln -sf ../lib/portage/bin/regenworld ${TARGET}/usr/sbin/regenworld
		ln -sf ../lib/portage/bin/emerge-webrsync ${TARGET}/usr/sbin/emerge-webrsync

		ln -sf ../lib/portage/bin/newins ../lib/portage/bin/donewins
		
		echo
		echo -e "Portage succesfully bootstrapped"
		echo
	else
		echo
		echo -e "`type -p emerge`"
		echo
	fi
}

bootstrap_progressive() {
	#This bootstraps a 'progressive' Gentoo for Mac OS X system.
	## TODO prompt to grab stage{1,2,3} from mirrors or install Xcode from CD/DVD/pkg
	gcc -v 2> /dev/null || missing_devtools
	bootstrap_python
	bootstrap_portage
	setup_users
	[ -f ${ROOT}/etc/make.profile ] && sudo rm -rf ${ROOT}/etc/make.profile
	[ -f ${ROOT}/${PORTDIR}/profiles ] || sudo mkdir -p ${ROOT}/${PORTDIR}/profiles
	sudo ln -sf ${ROOT}/${PORTDIR}/profiles/default-darwin/macos/progressive ${ROOT}/etc/make.profile || echo -n "Failed to properly link to ${PORTDIR}/profiles/${profile}"
	echo
	echo -n "Would you like to emerge sync now (y/n)? "
	read answer
	if [ $answer == "y" ]; then
		echo
		echo -e "Grabbing current Portage tree...."
		echo
		sudo emerge sync && echo "emerge sync complete." || echo "!!! emerge sync failed"
	else
		echo
		echo "Gentoo bootstrap finished. Please run emerge sync then emerge system."
		echo
	fi
	echo -n "We need to install the base system. Run emerge system now (y/n) ? "
	read answer
	if [ $answer == "y" ]; then
		echo
		sudo emerge -v system || echo "!!! emerge system failed"
	else
		echo
		echo "Before installing any packages, you must run emerge system."
		exit 1
	fi
	echo
	echo -n  "OK! Your Gentoo for Mac OS X system is complete."
	echo
	exit 1
	# TODO add links to docs
}

bootstrap_python() {

	TARGET=$1

		PV=${PYTHONVERSION}
		A=Python-${PV}.tar.bz2
		[ ! -d ${DISTDIR} ] && sudo mkdir -p {DISTDIR}
		if [ ! -e ${DISTDIR}/${A} ] ; then
			echo "Fetching Python..."
			cd ${DISTDIR} && sudo curl -O http://www.python.org/ftp/python/${PV%_*}/${A}
		fi
		export S="${PORTAGE_TMPDIR}/python-${PV}"
		export PYTHON_DISABLE_MODULES="readline pyexpat dbm gdbm bsddb _curses _curses_panel _tkinter"
		export PYTHON_DISABLE_SSL=1
		export OPT="${CFLAGS}"
		
		rm -rf ${S}
		mkdir -p ${S}
		cd ${S}
		echo "Unpacking Python..."
		sudo tar -jxf ${DISTDIR}/${A} || exit 1
		S=${S}/Python-${PV}
		echo "Configuring Python..."
		cd ${S}

		./configure \
			--enable-unicode=ucs4 \
			--prefix=${TARGET}/usr \
			--host=${CHOST} \
			--mandir=${TARGET}/usr/share/man \
			--infodir=${TARGET}/usr/share/info \
			--datadir=${TARGET}/usr/share \
			--sysconfdir=${TARGET}/etc \
			--localstatedir=${TARGET}/var/lib \
			--with-fpectl \
			--enable-shared \
			--disable-ipv6 \
			--infodir='${prefix}'/share/info \
			--mandir='${prefix}'/share/man \
			--with-threads \
			--with-cxx=no \
			|| exit 1
			sudo make ${MAKEOPTS} || exit 1
			sudo make altinstall || exit 1
			cd ${TARGET}/usr/bin
			sudo ln -sf python2.3 python
			
		echo
		echo -e "Python succesfully bootstrapped"
}

bootstrap_standard() {

	#This mounts the current .dmg installer if portage is not found, and links to the appropriate FEATURES="collision-protect" profile
	# TODO make / ${ROOT}
	
	gcc -v 2> /dev/null || missing_devtools
	
	if [ ! -x /usr/bin/emerge ] ; then
		A=gentoo-macos-${DMGVERSION}.dmg
		echo
		echo "Mounting Gentoo for Mac OS X Disk Image at ${DMGURL}/${A}"
		echo
		sudo hdid ${DMGURL}/${A} || echo "Could not mount remote image"
			# TODO check md5 sum/timeout
		export CM_BUILD=CM_BUILD
		sudo installer -verbose -pkg /Volumes/gentoo-macos/Gentoo\ for\ Mac\ OS\ X\ Installer.pkg -target / || exit 1
		sudo hdiutil unmount /Volumes/gentoo-macos/
		echo
		echo -e "Portage sucessfully installed"
		echo
	else
		echo "Portage seems to be installed. Setting up profile..."
	fi
	
	check_release_version
	sudo rm -rf /etc/make.profile
	sudo mkdir -p ${PORTDIR}/profiles
	sudo ln -sf ${PORTDIR}/profiles/${profile} /etc/make.profile || echo -n "Failed to properly link to ${PORTDIR}/profiles/${profile}"
	if [ ! -f /usr/portage/metadata/timestamp ]; then
		echo -e "Grabbing current Portage tree...."
		echo
		sudo emerge sync && echo "emerge sync complete." || echo "emerge sync failed. Please run this command manually" && exit 1
	fi
	sudo emerge -ev system && echo "emerge system complete." || echo "There were errors running emerge system. Please run this command manually" && exit 1
	echo -n  "OK! Your Gentoo for Mac OS X system is complete."
	echo
	exit 1
	# TODO add links to docs
}

check_release_version() {

	if [ -x `which sw_vers` ]; then
		NAME="Mac OS X"
		RV_MAJOR="`sw_vers | grep ProductVersion | sed s:'ProductVersion\:::' | awk '{print $1}' | cut -d. -f 1`"
		RV_MINOR="`sw_vers | grep ProductVersion | cut -d. -f 2`"
		RV_PATCH="`sw_vers | grep ProductVersion | cut -d. -f 3`"
		RV="${RV_MAJOR}.${RV_MINOR}"
		if [ ${RV_MINOR} -lt 3 ]; then
			echo "Sorry, you need at least Mac OS X 10.3 Panther."
			exit 1
		fi
		echo
		echo -e "It appears you are running Mac OS X ${RV_MAJOR}.${RV_MINOR}"
		echo
		profile="default-darwin/macos/${RV}"
		return
	else
		echo
		echo -e "It appears you are not running Mac OS X...Assuming its Darwin..."
		echo 
		bootstrap_od
		exit 1
	fi

}

create_dmg() {
	export CM_BUILD=CM_BUILD
	TARGET=${ROOT}/mnt/gentoo
	BUILDDIR=${PORTAGE_TMPDIR}/portage/build
	if [ -d ${BUILDIR} ]; then
		sudo rm -rf ${BUILDDIR}
	fi
	sudo mkdir -p ${BUILDDIR}/dmg ${TARGET}
	sudo hdiutil create -type UDIF -size 4.2g -fs HFS+J -volname gentoo -uid 0 -gid 0 ${BUILDDIR}/dmg/gentoo-osx.dmg
	sudo hdiutil attach ${BUILDDIR}/dmg/gentoo-osx.dmg -mountpoint ${TARGET} -nobrowse -owners on
	sudo installer -verbose -pkg ~/Desktop/BaseSystem.pkg -target ${TARGET}
	sudo installer -verbose -pkg ~/Desktop/Essentials.pkg -target ${TARGET}
	sudo installer -verbose -pkg ~/Desktop/BSD.pkg -target ${TARGET}
	sudo installer -verbose -pkg ~/Desktop/DeveloperTools.pkg -target ${TARGET}
	sudo installer -verbose -pkg ~/Desktop/DevSDK.pkg -target ${TARGET}
	sudo installer -verbose -pkg ~/Desktop/BSDSDK.pkg -target ${TARGET}
	sudo installer -verbose -pkg ~/Desktop/gcc3.3.pkg -target ${TARGET}
	# TODO check for incremental updates
	if [ -d ~/Desktop/MacOSXUpdateCombo10.3.8.pkg ];then
		sudo installer -verbose -pkg ~/Desktop/MacOSXUpdateCombo10.3.8.pkg -target ${TARGET}
	else
		echo
		echo -e "Mac OS X 10.3.8 Update not found...oh well, vanilla 10.3 it is."
		echo
	fi
	echo
	echo -e "Completed Installing Base System."
	echo
	[ ! -f ${TARGET}/var/log/CDIS.custom ] && sudo mkdir -p /var/log
	sudo echo 'LANGUAGE=English' > ${TARGET}/var/log/CDIS.custom
	echo
	echo "Updating mkext cache"
	sudo kextcache -K ${TARGET}/mach_kernel -a ${ARCH} -m ${TARGET}/System/Library/Extensions.mkext ${TARGET}/System/Library/Extensions 2>/dev/null
	sudo cp ${BOOTSTRAPSCRIPT} ${TARGET}/sbin && sudo chmod a+x ${TARGET}/sbin/"${0##*/}"
	## HACK we cant mount images in the chroot properly, so we copy the standard install pkg to the target before we chroot
	echo -n "Would you like this to be a standard install(no apple files will be modified) (y/n)? "
	read answer
	if [ $answer == "y" ]; then
		A=gentoo-macos-${DMGVERSION}.dmg
		echo
		echo "Mounting Gentoo for Mac OS X Disk Image at ${DMGURL}/${A}"
		echo
		sudo hdid ${DMGURL}/${A} || echo "Could not mount remote image"
			# TODO check md5 sum/timeout
		export CM_BUILD=CM_BUILD
		sudo installer -verbose -pkg /Volumes/gentoo-macos/Gentoo\ for\ Mac\ OS\ X\ Installer.pkg -target ${TARGET} || exit 1
		sudo hdiutil unmount /Volumes/gentoo-macos/
		echo -e "Portage installed on ${TARGET}"
	else
		echo -e "Ok, this will be a progressive chroot"
	fi
	echo -n "Would you like to chroot and complete the bootstrap process now (y/n)? "
	read answer
	if [ $answer == "y" ]; then
		echo
		if [ ! -c "${TARGET}/dev/null" ]; then
			echo "Mounting devfs..."
			sudo mkdir -p "${TARGET}/dev"
			sudo mount -t devfs stdin "${TARGET}/dev"
			sudo mount -t fdesc -o union stdin "${TARGET}/dev"
		else
			echo "devfs appears to exist..."
		fi
		echo "Mounting volfs..."
		[ -d "${TARGET}/sbin" ] || sudo mkdir -p "${TARGET}/sbin"
		[ -f "${TARGET}/sbin/mount_volfs" ] || sudo cp /sbin/mount_volfs ${TARGET}/sbin/
		[ -d "${TARGET}/.vol" ] || sudo mkdir -p "${TARGET}/.vol"
		## If the directory is empty, assume volfs is not mounted
		[ "$(echo ${TARGET}/.vol/*)" == "${TARGET}/.vol/*" ] && sudo /sbin/mount_volfs "${TARGET}/.vol"
		sudo chroot ${TARGET} /bin/bash
		echo
		echo -e "Buh bye."
		echo
		# we do once for devfs and once for fdesc
		sudo umount ${TARGET}/dev && sudo umount ${TARGET}/dev
		sudo umount ${TARGET}/.vol
	fi
	sudo hdiutil unmount ${TARGET}
	sudo mv ${BUILDDIR}/dmg/gentoo-osx.dmg ~/Desktop
	echo
	echo -e "Completed creating ~/Desktop/gentoo-osx.dmg"
	echo -e "To finish bootstrap, mount your new disk image, mount devfs, fdesc, volfs "
	echo -e "and enter the chroot. Once you are chrooted, run the bootstrap script like this: \n"
	echo -e "  /sbin/${0##*/} {standard,progressive} \n"
	echo
	exit 1
}

greeting() {
	echo
	echo -e "Gentoo for Mac OS X"
	echo -e "http://www.gentoo.org/"
	echo -e "Copyright 2005 The Gentoo Foundation"
	echo -e "Distributed under the GPLv2 and APSL-2 Licenses"
	echo
}

missing_devtools() {
	## TODO install from Xcode CD,pkg on local disk, or use tools in portage
	echo -e "Please install the Xcode Developer Tools available at http://developer.apple.com/tools/download"
	echo
	exit 1
	
	sudo installer -verbose -pkg ${DISTDIR}/DeveloperTools.pkg -target ${ROOT}
	sudo installer -verbose -pkg ${DISTDIR}/DevSDK.pkg -target ${ROOT}
	sudo installer -verbose -pkg ${DISTDIR}/BSDSDK.pkg -target ${ROOT}
	sudo installer -verbose -pkg ${DISTDIR}/gcc3.3.pkg -target ${ROOT}
}

setup_users() {
	TARGET=$1
	# TODO prompt current user to add to portage group
	if [ ! -d ${TARGET}/var/db/netinfo/local.nidb ]; then
        echo "Creating local NetInfo database"
        # loop until password was entered the same twice
		while [ 1 ]; do
			ROOT_PW=`openssl passwd`
			if [ ${?} == "0" ]; then
				break
        	fi
    	done
    	sudo mkdir -p ${TARGET}/var/db/netinfo/local.nidb
    	sudo nicl -raw ${TARGET}/var/db/netinfo/local.nidb -create /users/root passwd ${ROOT_PW}
    	sudo touch ${TARGET}/var/db/.AppleSetupDone	
		sudo nicl -raw ${TARGET}/var/db/netinfo/local.nidb -create /users/portage
		sudo nicl -raw ${TARGET}/var/db/netinfo/local.nidb -create /groups/portage
		sudo nicl -raw ${TARGET}/var/db/netinfo/local.nidb -create /users/portage uid 250
		sudo nicl -raw ${TARGET}/var/db/netinfo/local.nidb -create /users/portage gid 250
		sudo nicl -raw ${TARGET}/var/db/netinfo/local.nidb -create /groups/portage gid 250
	else
		sudo niutil -create ${TARGET} /users/portage
		sudo niutil -create ${TARGET} /groups/portage
		sudo niutil -createprop ${TARGET} /users/portage uid 250
		sudo niutil -createprop ${TARGET} /users/portage gid 250
		sudo niutil -createprop ${TARGET} /groups/portage gid 250
	fi

}

show_status() {
	local num=$1
	shift
	echo "  [[ ($num/6) $* ]]"
}

usage() {
	echo -e "Usage: ${HILITE}${0##*/}${NORMAL} ${GOOD}[options]${NORMAL}"
	echo -e "  ${GOOD}standard${NORMAL}     	Mac OS X Standard - no system files will be modified (requires Xcode)"
	echo -e "  ${GOOD}progressive${NORMAL}   Mac OS X Progressive - EXPERIMENTAL!! Tames your Panther."
	echo -e "  ${GOOD}dmg${NORMAL}  Creates a Mac OS X Disk Image suitable for a development chroot"
	exit 1
}

## End Functions

greeting

for ARG in "$@"; do
if [ "$ARG" == "progressive" ]; then
	echo "Progressive!"
	bootstrap_progressive
elif [ "$ARG" == "standard" ]; then
	bootstrap_standard
elif [ "$ARG" == "dmg" ]; then
	create_dmg
elif [ "$ARG" == "pythononly" ]; then
	bootstrap_python $2
elif [ "$ARG" == "portageonly" ]; then
	bootstrap_portage $2
fi
done
usage
