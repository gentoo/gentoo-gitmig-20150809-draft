# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Aaron Blew <moath@oddbox.org>
# /home/cvsroot/gentoo-x86/x11-terms/aterm/,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/x11-terms/aterm/aterm-0.4.0.ebuild,v 1.2 2001/08/30 17:31:36 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A terminal emulator with transparency support as well as rxvt backwards compatability"
SRC_URI="http://prdownloads.sourceforge.net/aterm/${A}"
HOMEPAGE="http://aterm.sourceforge.net"

DEPEND=">=media-libs/jpeg-6b-r2
		>=media-libs/libpng-1.0.11
		virtual/x11"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST} --enable-transparency \
	--enable-background-image --enable-menubar \
	--enable-graphics --with-x
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc TODO ChangeLog INSTALL doc/BUGS doc/FAQ doc/README.menu
    docinto menu
    dodoc doc/menu/*
    docinto html
    dodoc *.html

}

