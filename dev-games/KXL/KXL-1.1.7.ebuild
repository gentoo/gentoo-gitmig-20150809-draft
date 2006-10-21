# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/KXL/KXL-1.1.7.ebuild,v 1.9 2006/10/21 00:18:23 nyhm Exp $

inherit eutils

DESCRIPTION="Development Library for making games for X"
HOMEPAGE="http://kxl.orz.hm/"
SRC_URI="http://kxl.hn.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE=""

DEPEND="x11-libs/libX11"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README
}
