# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kde-i18n-ru/kde-i18n-ru-2.1.1.ebuild,v 1.3 2002/04/28 02:13:29 seemant Exp $

V=2.1
S=${WORKDIR}/${PN}
DESCRIPTION="KDE 2.1.1 - i18n"
SRC_PATH="kde/stable/${PV}/distribution/tar/generic/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.twoguys.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-${PV} app-text/docbook-sgml"
RDEPEND=">=kde-base/kdelibs-${PV}"

PROVIDE="virtual/kde-i18n-${PV}"

src_compile() {

	QTBASE=/usr/X11R6/lib/qt
	./configure --prefix=/opt/kde${V} --host=${CHOST} \
		--with-qt-dir=$QTBASE || die
	make || die
}

src_install() {
	make install DESTDIR=${D} || die
}
