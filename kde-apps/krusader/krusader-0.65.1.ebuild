# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-apps/krusader/krusader-0.65.1.ebuild,v 1.3 2000/10/23 11:27:15 achim Exp $

P=krusader-0.65-1
A=${P}.tar.gz
S=${WORKDIR}/krusader-0.65
DESCRIPTION="A Filemanager for KDE"
SRC_URI="http://krusader.sourceforge.net/distributions/${A}"
HOMEPAGE="http:/krusader.sourceforge.net/"

src_unpack () {
  unpack ${A}
  cp ${FILESDIR}/bookmaneditbase.h ${S}/${PN}/
  cp ${FILESDIR}/kfilelist.h ${S}/${PN}/
  cp ${FILESDIR}/vfs.cpp ${S}/${PN}/
  
}
src_compile() {
    cd ${S}
    rm catalog
    find /usr/share/sgml -name "catalog" -print -exec install-catalog -a catalog {} \;
    export SGML_CATALOG_FILES=${S}/catalog
    try ./configure --prefix=/opt/kde2 --host=${CHOST}
    try SGML_CATALOG_FILES=${S}/catalog make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install

}

