# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-0.65.1.ebuild,v 1.1 2000/09/18 17:25:27 achim Exp $

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
    ./configure --prefix=/opt/kde --host=${CHOST}
    make

}

src_install () {

    cd ${S}
    make DESTDIR=${D} install

}

