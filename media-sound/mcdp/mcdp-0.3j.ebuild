# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mcdp/mcdp-0.3j.ebuild,v 1.10 2004/10/30 10:54:22 eradicator Exp $

IUSE="diet"

inherit toolchain-funcs

DESCRIPTION="A very small console cd player"
HOMEPAGE="http://www.mcmilk.de/projects/mcdp/"
SRC_URI="http://www.mcmilk.de/projects/mcdp/dl/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86 amd64 sparc"
LICENSE="GPL-2"

DEPEND="diet? ( dev-libs/dietlibc )
	!diet? ( virtual/libc )"

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

	cd doc
	dodoc CHANGES INSTALL README THANKS profile.sh
}
