# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# /home/cvsroot/gentoo-x86/skel.build,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk-thinice-theme/gtk-thinice-theme-1.0.4-r1.ebuild,v 1.1 2001/10/06 10:08:19 azarah Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Gtk engine, thinice"
SRC_URI="http://thinice.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://thinice.sourceforge.net"

DEPEND=">=x11-libs/gtk+-1.2.10-r4"

src_compile() {
    try ./configure --prefix=/usr --host=${CHOST}
    try pmake
}

src_install () {
    try make prefix=${D}/usr install
}
