# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/asbutton/asbutton-0.3.ebuild,v 1.5 2004/04/27 21:11:29 agriffis Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="A simple dockable application launcher for use in AfterStep."
SRC_URI="http://www.tigr.net/afterstep/download/asbutton/${P}.tar.gz"
HOMEPAGE="http://www.tigr.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install () {
	dodir /usr/bin
	dodir /usr/share/afterstep/desktop/icons/16bpp

	make DESTDIR=${D} install || die
	dodoc README CHANGES
}
