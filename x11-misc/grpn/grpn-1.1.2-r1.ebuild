# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/grpn/grpn-1.1.2-r1.ebuild,v 1.3 2008/05/06 19:10:08 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="GRPN is a Reverse Polish Notation calculator for X"
HOMEPAGE="http://lashwhip.com/grpn.html"
SRC_URI="http://lashwhip.com/grpn/${P}.tar.gz"

RDEPEND="=x11-libs/gtk+-1.2*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ~ppc ~sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-implicit-declarations.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS} $(pkg-config --cflags gtk+) -DGTK_VER_1_1" \
		CC="$(tc-getCC)" || die "emake failed."
}

src_install () {
	dobin grpn
	doman grpn.1
	dodoc CHANGES README
}
