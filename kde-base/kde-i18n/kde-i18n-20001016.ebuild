# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-20001016.ebuild,v 1.1 2000/10/29 20:36:59 achim Exp $

A=kde-i18n-20001016.tar.bz2
S=${WORKDIR}/kde-i18n
DESCRIPTION="KDE 2Beta - Language Support"
SRC_URI="ftp://ftp.kde.org/pub/kde/snapshots/current/${A}
	 http://download.sourceforge.net/mirrors/kde/snapshots/curren//${A}"
HOMEPAGE="http://www.kde.org/"

src_unpack () {
  unpack ${A}
  cd ${S}
#  rm -r ca

}
src_compile() {
    cd ${S}
    rm catalog
    find /usr/share/sgml -name "catalog" -print -exec install-catalog -a catalog {} \;
    export SGML_CATALOG_FILES=${S}/catalog
    try ./configure --prefix=/opt/kde2 --host=${CHOST} \
		--with-qt-dir=/usr/lib/qt-x11-2.2.1 \
		--with-qt-includes=/usr/lib/qt-x11-2.2.1/include \
		--with-qt-libs=/usr/lib/qt-x11-2.2.1/lib
    cp Makefile Makefile.orig
    sed -e "s:br ca cy:br cy:" Makefile.orig > Makefile
    try SGML_CATALOG_FILES=${S}/catalog make
}

src_install() {
  try make install DESTDIR=${D}
  dodoc COPYING highscore
  docinto html
  dodoc highscore.html
}



