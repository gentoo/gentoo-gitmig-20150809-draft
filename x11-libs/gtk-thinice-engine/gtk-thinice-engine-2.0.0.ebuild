# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Spider <spider@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/x11-libs/gtk-thinice-theme/gtk-thinice-theme-1.0.4-r1.ebuild,v 1.2 2001/10/14 17:58:36 lordjoe Exp

SLOT="0"
S=${WORKDIR}/${P}
DESCRIPTION="Gtk engine, thinice"
SRC_URI="http://thinice.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://thinice.sourceforge.net"

DEPEND=">=x11-libs/gtk+-2.0.0"

src_compile() {
    ./configure --prefix=/usr --host=${CHOST} || die
    emake || die
}

src_install () {
    make prefix=${D}/usr install || die
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
}

