# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/grpn/grpn-1.1.2-r1.ebuild,v 1.4 2009/12/19 19:38:44 ssuominen Exp $

EAPI=1

inherit eutils toolchain-funcs

DESCRIPTION="a graphical reverse polish notatiton (RPN) calculator for GTK+-1.2"
HOMEPAGE="http://lashwhip.com/grpn.html"
SRC_URI="http://lashwhip.com/grpn/${P}.tar.gz"

RDEPEND="x11-libs/gtk+:1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ppc ~sparc x86"
IUSE=""

# There's no real test suite and it fails to compile with forced asneeded
RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-implicit-declarations.patch
	sed -i \
		-e 's/$(CC) $(DFLAGS)/$(CC) $(LDFLAGS) $(DFLAGS)/g' \
		Makefile || die
}

src_compile() {
	emake CFLAGS="${CFLAGS} $(pkg-config --cflags gtk+) -DGTK_VER_1_1" \
		CC=$(tc-getCC) || die "emake failed."
}

src_install() {
	dobin grpn || die "dobin failed."
	doman grpn.1
	dodoc CHANGES README
	make_desktop_entry grpn "RPN calculator" calc
}
