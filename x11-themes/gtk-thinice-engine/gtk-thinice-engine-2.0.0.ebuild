# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-thinice-engine/gtk-thinice-engine-2.0.0.ebuild,v 1.4 2002/08/01 11:59:04 seemant Exp $

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

