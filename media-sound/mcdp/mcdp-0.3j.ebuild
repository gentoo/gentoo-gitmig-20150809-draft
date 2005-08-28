# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mcdp/mcdp-0.3j.ebuild,v 1.13 2005/08/28 06:08:48 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A very small console cd player"
HOMEPAGE="http://www.mcmilk.de/projects/mcdp/"
SRC_URI="http://www.mcmilk.de/projects/mcdp/dl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE="diet"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-dietlibc-fix.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin mcdp || die
	doman mcdp.1 || die

	cd doc
	dodoc CHANGES INSTALL README THANKS profile.sh
}
