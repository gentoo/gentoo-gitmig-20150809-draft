# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde.eclass,v 1.8 2001/10/01 11:04:22 danarmak Exp $
# The kde eclass is inherited by all kde-* eclasses. Few ebuilds inherit straight from here.
. /usr/portage/eclass/inherit.eclass || die
inherit autoconf base || die
ECLASS=kde

DESCRIPTION="Based on the $ECLASS eclass"

HOMEPAGE="http://www.kde.org/"

DEPEND="$DEPEND kde-base/kdelibs"
RDEPEND="$RDEPEND kde-base/kdelibs"

kde_src_compile() {

    echo "in kde_src_compile, 1st parameter is $1"
    [ -z "$1" ] && kde_src_compile all

    while [ "$1" ]; do

	case $1 in
		myconf)
			echo "in kde_src_compile, action is myconf"
			use qtmt 	&& myconf="$myconf --enable-mt"
			use objprelink	&& myconf="$myconf --enable-objprelink" || myconf="$myconf --disable-objprelink"
			;;
		configure)
			echo "in kde_src_compile, action is configure"
			./configure --host=${CHOST} --with-x \
			${myconf} --with-xinerama || die
			;;
		make)
			echo "in kde_src_compile, action is make"
			make || die
			;;
		all)
			echo "in kde_src_compile, action is all"
			kde_src_compile myconf configure make
			;;
	esac

    shift
    done

}

kde_src_install() {

	echo "in kde-base_src_compile, 1st parameter is $1"
    [ -z "$1" ] && kde_src_install all

    while [ "$1" ]; do

	case $1 in
	    make)
			echo "in kde_src_install, action is make"
			make install DESTDIR=${D} || die
			;;
	    dodoc)
			echo "in kde_src_install, action is dodoc"
			dodoc AUTHORS ChangeLog README*
			;;
	    all)
			echo "in kde_src_install, action is all"
			kde_src_install make dodoc
			;;
	esac

    shift
    done

}

EXPORT_FUNCTIONS src_compile src_install

