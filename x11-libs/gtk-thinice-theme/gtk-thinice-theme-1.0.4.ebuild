# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# /home/cvsroot/gentoo-x86/skel.build,v 1.2 2001/02/15 18:17:31 achim Exp

S=${WORKDIR}/${P}
DESCRIPTION="Gtk engine, thinice"
SRC_URI="http://thinice.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://thinice.sourceforge.net"

DEPEND=">=x11-libs/gtk+-1.2.10"

src_compile() {
    try ./configure --prefix=/usr/X11R6 --host=${CHOST}
    try pmake
}

src_install () {
    try make prefix=${D}/usr/X11R6 install
}
