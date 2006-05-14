# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/id3v2/id3v2-0.1.11.ebuild,v 1.7 2006/05/14 12:16:14 flameeyes Exp $

inherit eutils toolchain-funcs

IUSE=""

DESCRIPTION="A command line editor for id3v2 tags."
HOMEPAGE="http://id3v2.sourceforge.net/"
SRC_URI="mirror://sourceforge/id3v2/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ppc ~ppc64 sparc x86"

DEPEND="media-libs/id3lib"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix segfault on alpha (and probably other architectures)
	epatch "${FILESDIR}/${P}-alpha.patch"
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" LDFLAGS="${LDFLAGS}" OPT_CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	dobin id3v2
	doman id3v2.1
	dodoc README
}
