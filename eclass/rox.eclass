# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/rox.eclass,v 1.1 2004/11/26 18:05:51 sergey Exp $

# Author: Sergey Kuleshov <svyatogor@gentoo.org>
#
# This eclass is intended to be used with Rox desktop application.
# See ebuilds in rox-extras/ for examples.

ECLASS=rox
INHERITED="$INHERITED $ECLASS"

if [ -z "$ROX_VER" ]; then
	ROX_VER="2.1.0"
fi

DEPEND="${DEPEND}
		>=app-rox/rox-$ROX_VER"

if [ -n "$ROX_LIB_VER" ]; then
	DEPEND="${DEPEND}
			  >=app-rox/rox-lib-$ROX_LIB_VER"
fi

if [ -n "$ROX_CLIB_VER" ]; then
	DEPEND="${DEPEND}
			  >=app-rox/rox-clib-$ROX_CLIB_VER"
fi


rox_src_compile() {
	cd $APPNAME
	#Some packages need to be compiled.
	chmod 755 ./AppRun
	if [ -d "src/" ]; then
		./AppRun --compile || die "Failed to compile the package" 
		rm -rf src
	fi
}

rox_src_install() {
	dodir /usr/lib/rox/
	if [ -d "$APPNAME/Help/" ]; then
		for i in $APPNAME/Help/*; do
			dodoc "$i"
		done
	fi
	cp -r $APPNAME ${D}/usr/lib/rox/
}

rox_pkg_postinst() {
	einfo "The $APPNAME has been installed into /usr/lib/rox"
	einfo "You can run it by pointing Rox file manage to that location"
	einfo "and click on new application"
}

EXPORT_FUNCTIONS src_compile src_install pkg_postinst
