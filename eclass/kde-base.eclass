# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-base.eclass,v 1.6 2001/09/29 14:57:23 danarmak Exp $
# This is the kde ebuild for >=2.2.1 kde base packages. Don't use for kdelibs though :-)
# It can't be used for e.g. kdevelop, koffice because of their separate versionnig schemes.
. /usr/portage/eclass/inherit.eclass || die
inherit c autoconf base || die
ECLASS=kde-base

DESCRIPTION="KDE ${PV} - "
HOMEPAGE="http://www.kde.org/"

SRC_PATH="kde/stable/${PV}/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

DEPEND="${DEPEND}
	( kde-base/kdelibs-${PV} )
	objprelink? ( dev-util/objprelink )
	>=x11-libs/qt-x11-2.3.0"

RDEPEND="${RDEPEND}
	( kde-base/kdelibs-${PV} )
	>=x11-libs/qt-x11-2.3.0"

kde-base_src_compile() {

    echo "in kde-base_src_compile, 1st parameter is $1"
    [ -z "$1" ] && kde-base_src_compile all

    while [ "$1" ]; do

	case $1 in
		myconf)
			echo "in kde-base_src_compile, action is myconf"
			use qtmt 	&& myconf="$myconf --enable-mt"
			use mitshm	&& myconf="$myconf --enable-mitshm"
			use objprelink	&& myconf="$myconf --enable-objprelink"
			;;
		configure)
			echo "in kde-base_src_compile, action is configure"
			./configure --host=${CHOST} --with-x \
			${myconf} --with-xinerama || die
			;;
		make)
			echo "in kde-base_src_compile, action is make"
			make || die
			;;
		all)
			echo "in kde-base_src_compile, action is all"
			kde-base_src_compile myconf configure make
			;;
	esac
	
    shift
    done

}

kde-base_src_install() {
    
    echo "in kde-base_src_install, 1st parameter is $1"
    [ -z "$1" ] && kde-base_src_install all

    while [ "$1" ]; do

	case $1 in
	    make)
		echo "in kde-base_src_install, action is make"
		make install DESTDIR=${D} || die
		;;
	    dodoc)
		echo "in kde-base_src_install, action is dodoc"
		dodoc AUTHORS ChangeLog COPYING README*
		;;
	    all)
		echo "in kde-base_src_install, action is all"
		kde-base_src_install make dodoc
		;;
	esac
	
    shift
    done
  
}


EXPORT_FUNCTIONS src_compile src_install

