# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde.eclass,v 1.6 2001/09/29 14:57:23 danarmak Exp $
# This is the kde ebuild for std. kde-dependant apps which follow configure/make/make install
# procedures and have std. configure options. That includes kdevelop, koffice etc.
. /usr/portage/eclass/inherit.eclass || die
inherit c autoconf base || die
ECLASS=kde

DESCRIPTION="Based on the $ECLASS eclass"
HOMEPAGE="http://apps.kde.org/"

DEPEND="${DEPEND}
	kde-base/kdelibs
	objprelink? ( dev-util/objprelink )
	x11-libs/qt-x11"
RDEPEND="${RDEPEND}
	kde-base/kdelibs
	x11-libs/qt-x11"

kde_src_compile() {

	echo "in kde-base_src_compile, 1st parameter is $1"
    [ -z "$1" ] && kde_src_compile all

    while [ "$1" ]; do

	case $1 in
	    myconf)
			echo "in kde_src_compile, action is myconf"
			use qtmt 		&& myconf="$myconf --enable-mt"
			use mitshm		&& myconf="$myconf --enable-mitshm"
	        use objprelink	&& myconf="$myconf --enable-objprelink"
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


