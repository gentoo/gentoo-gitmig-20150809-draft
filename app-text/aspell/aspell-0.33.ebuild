# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/aspell/aspell-0.33.ebuild,v 1.2 2001/05/28 14:32:32 achim Exp $


A=${PN}-.33.tar.gz
S=${WORKDIR}/${PN}-.33
DESCRIPTION="A spell checker replacement for ispell"
SRC_URI="http://download.sourceforge.net/aspell/${A}"
HOMEPAGE="http://aspell.sourceforge.net"

DEPEND=">=app-text/pspell-0.12
	>=sys-libs/ncurses-5.2"

src_compile() {

    if [ "`use gpm`" ]
    then
      myldflags="-lgpm"
    fi
    try LDFLAGS=\"$myldflags\" ./configure --prefix=/usr --sysconfdir=/etc/aspell --host=${CHOST} --enable-doc-dir=/usr/share/doc/${P}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    cd ${D}/usr/share/doc/${P}
    mv man-html html
    mv man-text txt
    prepalldocs
    cd ${S}
    
    dodoc README* TODO

}

