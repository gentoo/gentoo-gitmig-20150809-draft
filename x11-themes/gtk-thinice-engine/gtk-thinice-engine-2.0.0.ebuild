# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-thinice-engine/gtk-thinice-engine-2.0.0.ebuild,v 1.5 2002/10/04 06:47:18 vapier Exp $

SLOT="0"
S=${WORKDIR}/${P}
DESCRIPTION="Gtk engine, thinice"
SRC_URI="http://thinice.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://thinice.sourceforge.net"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=x11-libs/gtk+-2.0.0"

src_compile() {
    ./configure --prefix=/usr --host=${CHOST} || die
    emake || die
}

src_install () {
    make prefix=${D}/usr install || die
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
}

