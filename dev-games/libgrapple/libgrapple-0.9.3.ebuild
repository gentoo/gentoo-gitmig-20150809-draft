# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/libgrapple/libgrapple-0.9.3.ebuild,v 1.1 2008/06/30 19:57:23 nyhm Exp $

inherit eutils autotools

DESCRIPTION="A high level network layer for multiuser applications"
HOMEPAGE="http://grapple.linuxgamepublishing.com/grapple.php"
SRC_URI="http://osfiles.linuxgamepublishing.com/${P}.tbz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/openssl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-64bit.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README* UPDATES
}
