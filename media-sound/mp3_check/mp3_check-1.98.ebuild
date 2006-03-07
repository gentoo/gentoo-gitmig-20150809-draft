# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3_check/mp3_check-1.98.ebuild,v 1.15 2006/03/07 15:05:17 flameeyes Exp $

inherit eutils toolchain-funcs

IUSE=""

DESCRIPTION="MP3 consistency checker"
HOMEPAGE="http://sourceforge.net/projects/mp3check/"
SRC_URI="mirror://sourceforge/mp3check/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc amd64"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}
src_install () {
	dobin mp3_check
	dodoc WISHLIST TODO THANKYOU README *NOTES FOR_TESTING GOALS MILESTONE*
}
