# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-0.65.1.ebuild,v 1.4 2000/11/07 10:21:03 achim Exp $

P=krusader-0.65-1
A=${P}.tar.gz
S=${WORKDIR}/krusader-0.65
DESCRIPTION="A Filemanager for KDE"
SRC_URI="http://krusader.sourceforge.net/distributions/${A}"
HOMEPAGE="http:/krusader.sourceforge.net/"

DEPEND=">=kde-base/kdelibs-2.0
	>=app-text/openjade-1.3
	>=app-text/sgml-common-0.3
	>=app-text/docbook-dtd31-sgml-1.0
	>=app-text/docbook-style-dsssl-1.57"
RDEPEND=">=kde-base/kdelibs-2.0"

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

