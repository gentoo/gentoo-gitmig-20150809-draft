# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gbase/gbase-0.5.ebuild,v 1.1 2008/01/16 12:43:04 drac Exp $

inherit eutils toolchain-funcs

DESCRIPTION="a convert program for decimal, hexadecimal, octal and binary values."
HOMEPAGE="http://www.fluxcode.net"
SRC_URI="http://www.fluxcode.net/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gtk.patch
}

src_compile() {
	tc-export CC
	emake || die "emake failed."
}

src_install() {
	dobin ${PN}
	dodoc README
}
