# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-2.1_beta2.ebuild,v 1.1 2001/01/30 21:58:32 achim Exp $

V=2.1-beta2
A=${PN}-${V}.tar.bz2
S=${WORKDIR}/${PN}-${V}
DESCRIPTION="KDE 2.1 Beta 2 - i18n"
SRC_PATH="kde/unstable/distribution/2.1beta2/tar/generic/src/${A}"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	 ftp://ftp.twoguys.org/pub/$SRC_PATH
	 ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

HOMEPAGE="http://www.kde.org/"

DEPEND=">=kde-base/kdelibs-2.0.1"

src_unpack() {
  unpack ${A}
}

src_compile() {
    QTBASE=/usr/X11R6/lib/qt

    find /usr/share/sgml -name "catalog" -print -exec install-catalog -a catalog {} \;
    export SGML_CATALOG_FILES=${S}/catalog
    try ./configure --prefix=/opt/kde${V} --host=${CHOST} \
		--with-qt-dir=$QTBASE
    try SGML_CATALOG_FILES=${S}/catalog make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc COPYING highscore
  docinto html
  dodoc highscore.html
}


