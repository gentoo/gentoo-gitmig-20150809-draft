# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/autocutsel/autocutsel-0.6.2.ebuild,v 1.8 2004/04/26 14:45:05 agriffis Exp $

DESCRIPTION="Synchronise the two copy/paste buffers mainly used by X applications"
HOMEPAGE="http://www.lepton.fr/tools/autocutsel/"
SRC_URI="http://www.lepton.fr/tools/autocutsel/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc
	virtual/x11"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
