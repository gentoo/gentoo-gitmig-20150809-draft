# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mpage/mpage-2.5.4.ebuild,v 1.5 2006/08/11 22:46:58 weeve Exp $

inherit eutils

DESCRIPTION="Many to one page printing utility"
HOMEPAGE="http://www.mesa.nl/"
SRC_URI="http://www.mesa.nl/pub/mpage/${P}.tgz"

KEYWORDS="~amd64 ppc sparc x86"
LICENSE="freedist"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${P}-gcc4.patch
}
src_compile() {
	emake \
		CFLAGS="$CFLAGS \$(DEFS)" \
		PREFIX=/usr \
		MANDIR=/usr/share/man/man1 || die "emake failed"
}

src_install () {
	make \
		PREFIX="${D}/usr" \
		MANDIR="${D}/usr/share/man/man1" install || die "make install failed"
	dodoc CHANGES Encoding.format FAQ NEWS README TODO || die "dodoc failed"
}
