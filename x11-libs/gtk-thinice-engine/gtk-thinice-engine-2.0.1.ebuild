# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk-thinice-engine/gtk-thinice-engine-2.0.1.ebuild,v 1.1 2002/06/14 00:14:24 spider Exp $

SLOT="0"
S=${WORKDIR}/${P}
DESCRIPTION="Gtk engine, thinice"
SRC_URI="http://thinice.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://thinice.sourceforge.net"

DEPEND=">=x11-libs/gtk+-2.0.0"
RDEPEND=$DEPEND
LICENSE="GPL-2"

src_compile() {
	econf
	emake || die
}

src_install () {
	einstall
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
}

