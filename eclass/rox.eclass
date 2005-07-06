# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/rox.eclass,v 1.4 2005/07/06 20:20:04 agriffis Exp $

# ROX eclass Version 2

# This eclass was created by Sergey Kuleshov (svyatogor@gentoo.org) and
# Alexander Simonov (devil@gentoo.org.ua) to ease installation of ROX desktop
# applications.

# APPNAME - the actual name of the application as the app folder is named
# ROX_VER - the minimum version of rox filer required. Default is 2.1.0
# ROX_LIB_VER - version of rox-lib required if any
# ROX_CLIB_VER - version of rox-clib required if any
# SET_PERM - specifies if permisions for arch specific files need to  be set

# For examples refer to ebuilds in rox-extra/

INHERITED="$INHERITED $ECLASS"

if [ -z "$ROX_VER" ]; then
	ROX_VER="2.1.0"
fi

DEPEND="${DEPEND}
		>=rox-base/rox-$ROX_VER"

if [ -n "$ROX_LIB_VER" ]; then
	DEPEND="${DEPEND}
			  >=rox-base/rox-lib-$ROX_LIB_VER"
fi

if [ -n "$ROX_CLIB_VER" ]; then
	DEPEND="${DEPEND}
			  >=rox-base/rox-clib-$ROX_CLIB_VER"
fi


rox_src_compile() {
	cd ${APPNAME}
	#Some packages need to be compiled.
	chmod 755 ./AppRun
	if [ -d "src/" ]; then
		./AppRun --compile || die "Failed to compile the package" 
		rm -rf src
	fi
}

rox_src_install() {
	if [ -d "$APPNAME/Help/" ]; then
		for i in $APPNAME/Help/*; do
			dodoc "$i"
		done
	fi
	insinto /usr/lib/rox
	doins -r ${APPNAME}
	#set correct permisions on files, in case they are wrong 
	chmod 755 ${D}/usr/lib/rox/${APPNAME}/AppRun
	chmod 755 ${D}/usr/lib/rox/${APPNAME}/AppletRun

	# set permisions for programms where we have libdir script
	if [ -f ${D}/usr/lib/rox/${APPNAME}/libdir ]; then
	    chmod 755 ${D}/usr/lib/rox/${APPNAME}/libdir
	fi

	# set permisiaon for programms where we have rox_run script (all who using rox-clib )
	if [ -f ${D}/usr/lib/rox/${APPNAME}/rox_run ]; then
	    chmod 755 ${D}/usr/lib/rox/${APPNAME}/rox_run
	fi

	# some programms have choice_install script
	if [ -f ${D}/usr/lib/rox/${APPNAME}/choice_install ]; then
	    chmod 755 ${D}/usr/lib/rox/${APPNAME}/choice_install
	fi

	# set permisions on all binares files for compiled programms per arch
	if [ -n "$SET_PERM" ]; then
	    ARCH="`uname -m`"
	    case $ARCH in
		i?86) ARCH=ix86 ;;
	    esac
	    PLATFORM="`uname -s`-$ARCH" 
	    chmod -R 755 ${D}/usr/lib/rox/${APPNAME}/${PLATFORM}
	fi

	#create a script in bin to run the application from command line
	dodir /usr/bin/
	echo "#!/bin/sh" > "${D}/usr/bin/${APPNAME}"
	echo "exec /usr/lib/rox/${APPNAME}/AppRun \"\$@\"" >> "${D}/usr/bin/${APPNAME}"
	chmod a+x ${D}/usr/bin/${APPNAME}
}

rox_pkg_postinst() {
	einfo "The $APPNAME has been installed into /usr/lib/rox"
	einfo "You can run it by enter $APPNAME in command line or"
	einfo "can run it by pointing Rox file manage to that location"
	einfo "and click on new application"
}

EXPORT_FUNCTIONS src_compile src_install pkg_postinst
