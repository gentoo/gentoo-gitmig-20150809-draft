# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xdelta/xdelta-1.1.3.ebuild,v 1.13 2004/07/15 00:14:39 agriffis Exp $

inherit gnuconfig

DESCRIPTION="Computes changes between binary or text files and creates deltas"
SRC_URI="mirror://sourceforge/xdelta/${P}.tar.gz"
HOMEPAGE="http://xdelta.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "
IUSE=""

DEPEND="=dev-libs/glib-1.2*
	>=sys-libs/zlib-1.1.4"

src_unpack() {
	unpack ${A} ; cd ${S}

	gnuconfig_update
}

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING NEWS README
}
