# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mcdp/mcdp-0.3j.ebuild,v 1.12 2005/07/25 13:19:38 dholm Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A very small console cd player"
HOMEPAGE="http://www.mcmilk.de/projects/mcdp/"
SRC_URI="${HOMEPAGE}/dl/${P}.tar.gz"
IUSE="diet"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
LICENSE="GPL-2"
DEPEND="diet? ( dev-libs/dietlibc )"
RDEPEND="!diet? ( virtual/libc )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-dietlibc-fix.patch
}

src_compile() {
	if use diet; then
		emake || die
	else
		emake CC="$(tc-getCC)" || die
	fi
}

src_install() {
	dobin mcdp || die
	doman mcdp.1 || die

	cd ${S}/doc
	dodoc CHANGES INSTALL README THANKS profile.sh
}
