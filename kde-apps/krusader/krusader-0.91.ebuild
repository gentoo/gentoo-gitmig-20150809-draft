# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-apps/krusader/krusader-0.91.ebuild,v 1.1 2001/05/14 10:50:24 achim Exp $

A=${PN}-0.91-1.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Filemanager for KDE"
SRC_URI="http://krusader.sourceforge.net/distributions/${A}"
HOMEPAGE="http:/krusader.sourceforge.net/"

DEPEND=">=kde-base/kdelibs-2.0
	>=app-text/openjade-1.3
	>=app-text/sgml-common-0.3"
RDEPEND=">=kde-base/kdelibs-2.0"

src_compile() {
    try ./configure --prefix=${KDEDIR} --host=${CHOST}
    try make
}

src_install () {

    try make DESTDIR=${D} install

}

