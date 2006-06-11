# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/rox.eclass,v 1.12 2006/06/11 23:17:22 dragonheart Exp $

# ROX eclass Version 2

# This eclass was created by Sergey Kuleshov (svyatogor@gentoo.org) and
# Alexander Simonov (devil@gentoo.org.ua) to ease installation of ROX desktop
# applications. Enhancements and python additions by Peter Hyman.

# APPNAME - the actual name of the application as the app folder is named
# ROX_VER - the minimum version of rox filer required. Default is 2.1.0
# ROX_LIB_VER - version of rox-lib required if any
# ROX_CLIB_VER - version of rox-clib required if any
# SET_PERM - specifies if permisions for arch specific files need to  be set
#    *** not needed anymore ***
#    note: user no longer has to set SET_PERM in ebuild files since the eclass
#    will now detect when it has to chmod on-the-fly
#    *** new ***
# KEEP_SRC - this flag, if set, will not remove the source directory
#    but will do a make clean in it. This is useful if users wish to
#    preserve the source code for anything

# For examples refer to ebuilds in rox-extra/

# need python to byte compile modules, if any
inherit python

if [ -z "${ROX_VER}" ]; then
	ROX_VER="2.1.0"
fi

DEPEND="${DEPEND}
		>=rox-base/rox-${ROX_VER}"

if [ -n "${ROX_LIB_VER}" ]; then
	DEPEND="${DEPEND}
			  >=rox-base/rox-lib-${ROX_LIB_VER}"
fi

if [ -n "${ROX_CLIB_VER}" ]; then
	DEPEND="${DEPEND}
			  >=rox-base/rox-clib-${ROX_CLIB_VER}"
fi


rox_src_compile() {
	cd "${APPNAME}"
	#Some packages need to be compiled.
	chmod 755 ./AppRun
	if [ -d src/ ]; then
		./AppRun --compile || die "Failed to compile the package"
		if [ -n "${KEEP_SRC}" ]; then
			cd src
			make clean
			cd ..
		else
			rm -rf src
		fi
		# set permissions flag here!
		SET_PERM=true
	fi
}

rox_src_install() {
	if [ -d "${APPNAME}/Help/" ]; then
		for i in "${APPNAME}"/Help/*; do
			dodoc "${i}"
		done
	fi
	insinto /usr/lib/rox
	doins -r ${APPNAME}

	#set correct permissions on files, in case they are wrong
	#include all subdirectories in search, just in case
	find "${D}/usr/lib/rox/${APPNAME}" -name 'AppRun' -print0 | xargs -0 chmod 755 >/dev/null 2>&1
	find "${D}/usr/lib/rox/${APPNAME}" -name 'AppletRun' -print0 | xargs -0 chmod 755 >/dev/null 2>&1

	# set permissions for programs where we have libdir script
	if [ -f "${D}/usr/lib/rox/${APPNAME}/libdir" ]; then
		chmod 755 "${D}/usr/lib/rox/${APPNAME}/libdir"
	fi

	# set permissions for programs where we have rox_run script (all who using rox-clib )
	if [ -f "${D}/usr/lib/rox/${APPNAME}/rox_run" ]; then
	    chmod 755 "${D}/usr/lib/rox/${APPNAME}/rox_run"
	fi

	# some programs have choice_install script
	if [ -f "${D}/usr/lib/rox/${APPNAME}/choice_install" ]; then
	    chmod 755 "${D}/usr/lib/rox/${APPNAME}/choice_install"
	fi

	# set permissions on all binares files for compiled programs per arch
	if [ -n "${SET_PERM}" ]; then
	    ARCH="`uname -m`"
	    case ${ARCH} in
		i?86) ARCH=ix86 ;;
	    esac
	    PLATFORM="`uname -s`-${ARCH}"
	    chmod -R 755 "${D}/usr/lib/rox/${APPNAME}/${PLATFORM}"
	fi

	#create a script in bin to run the application from command line
	dodir /usr/bin/
	cat >"${D}/usr/bin/${APPNAME}" <<EOF
#!/bin/sh
exec "/usr/lib/rox/${APPNAME}/AppRun" "\$@"
EOF
	chmod 755 "${D}/usr/bin/${APPNAME}"

	#now compile any and all python files
	python_mod_optimize "${D}/usr/lib/rox/${APPNAME}" >/dev/null 2>&1
}

rox_pkg_postinst() {
	einfo "${APPNAME} has been installed into /usr/lib/rox"
	einfo "You can run it by typing ${APPNAME} at the command line."
	einfo "Or, you can run it by pointing the ROX file manager to the"
	einfo "install location -- /usr/lib/rox/${APPNAME} -- and click"
	einfo "on ${APPNAME}'s icon, drag it to a panel, desktop, etc."
}

EXPORT_FUNCTIONS src_compile src_install pkg_postinst
