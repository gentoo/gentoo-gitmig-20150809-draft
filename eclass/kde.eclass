# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>Xx
# $Header: /var/cvsroot/gentoo-x86/eclass/kde.eclass,v 1.11 2001/10/05 11:46:29 danarmak Exp $
# The kde eclass is inherited by all kde-* eclasses. Few ebuilds inherit straight from here.
inherit autoconf base || die
ECLASS=kde

DESCRIPTION="Based on the $ECLASS eclass"

HOMEPAGE="http://www.kde.org/"

DEPEND="$DEPEND kde-base/kdelibs
				objprelink? ( >=dev-util/objprelink-0-r1 )"
RDEPEND="$RDEPEND kde-base/kdelibs"

kde-objprelink-patch() {
	debug-print-function kde-objprelink-patch $*
	use objprelink && cd ${S} && patch -p0 < /usr/share/objprelink/kde-admin-acinclude.patch || die
}

kde_src_compile() {

    debug-print-function kde_src_compile $*
    [ -z "$1" ] && kde_src_compile all

    while [ "$1" ]; do

	case $1 in
		myconf)
			debug-print-section myconf
			myconf="--host=${CHOST} --with-x --enable-mitshm --with-xinerama --prefix=${KDEDIR}"
			use qtmt 	&& myconf="$myconf --enable-mt"
			use objprelink	&& myconf="$myconf --enable-objprelink" || myconf="$myconf --disable-objprelink"
			;;
		configure)
			debug-print-section configure
			./configure ${myconf} || die
			;;
		make)
			debug-print-section make
			make || die
			;;
		all)
			debug-print-section all
			kde_src_compile myconf configure make
			;;
	esac

    shift
    done

}

kde_src_install() {

	debug-print-function kde_src_install $*
    [ -z "$1" ] && kde_src_install all

    while [ "$1" ]; do

	case $1 in
	    make)
			debug-print-section make
			make install DESTDIR=${D} destdir=${D} || die
			;;
	    dodoc)
			debug-print-section dodoc
			dodoc AUTHORS ChangeLog README* COPYING NEWS TODO
			;;
	    all)
			debug-print-section all
			kde_src_install make dodoc
			;;
	esac

    shift
    done

}

EXPORT_FUNCTIONS src_compile src_install

