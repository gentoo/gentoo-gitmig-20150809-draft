# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-i18n.eclass,v 1.2 2001/09/30 21:43:05 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit autoconf base || die
ECLASS=kde-i18n

A=${P}.tar.bz2
S=${WORKDIR}/${PN}
DESCRIPTION="KDE ${PV} - i18n: ${PN}"
SRC_PATH="kde/stable/${PV}/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-${PV}"

PROVIDE="virtual/kde-i18n-${PV}"

kde-i18n_src_compile() {
    
	echo "in kde-i18n_src_compile, 1st parameter is $1"
	[ $1="" ] && kde-i18n_src_compile all

	while [ "$1" ]; do

	case $1 in
		configure)
			echo "in kde-i18n_src_compile, action configure"
			./configure --host=${CHOST} || die
			;;
		make)
			echo "in kde-i18n_src_compile, action make"
			make || die
			;;
		all)
			echo "in kde-i18n_src_compile, action all"
			kde-i18n_src_compile all
			;;
	esac

	shift
	done

}

kde-i18n_src_install() {
	echo "in kde-i18n_src_compile, single function"
	make install DESTDIR=${D} || die
}


