# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-0.91.ebuild,v 1.4 2001/09/29 21:03:25 danarmak Exp $

A=${PN}-0.91-1.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Filemanager for KDE"
SRC_URI="http://krusader.sourceforge.net/distributions/${A}"
HOMEPAGE="http:/krusader.sourceforge.net/"

DEPEND=">=kde-base/kdelibs-2.0"


src_compile() {
    local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
      myconf="$myconf --enable-mitshm"
    try ./configure --prefix=${KDEDIR} --host=${CHOST} $myconf
    try make
}

src_install () {

    try make DESTDIR=${D} install

}

