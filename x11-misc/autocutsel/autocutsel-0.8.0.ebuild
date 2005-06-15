# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/autocutsel/autocutsel-0.8.0.ebuild,v 1.1 2005/06/15 09:22:08 pyrania Exp $

DESCRIPTION="Synchronise the two copy/paste buffers mainly used by X applications"
HOMEPAGE="http://www.lepton.fr/tools/autocutsel/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"

DEPEND="virtual/libc
	virtual/x11"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
