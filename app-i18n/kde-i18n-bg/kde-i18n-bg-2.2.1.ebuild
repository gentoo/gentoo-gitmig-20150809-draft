# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kde-i18n-bg/kde-i18n-bg-2.2.1.ebuild,v 1.1 2001/09/19 19:37:48 danarmak Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${PN}
DESCRIPTION="KDE ${PV} - i18n"
SRC_PATH="kde/stable/${PV}/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-${PV}"

PROVIDE="virtual/kde-i18n-${PV}"

src_compile() {
    
    . /etc/env.d/{kde${PV},qt}
    ./configure --host=${CHOST} || die
    make || die
}

src_install() {
  make install DESTDIR=${D} || die
}


