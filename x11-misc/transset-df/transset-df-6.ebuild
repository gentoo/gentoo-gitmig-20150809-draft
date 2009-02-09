# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/transset-df/transset-df-6.ebuild,v 1.4 2009/02/09 16:43:34 angelos Exp $

inherit eutils toolchain-funcs

DESCRIPTION="a patched version of xorg's transset"
HOMEPAGE="http://forchheimer.se/transset-df/"
SRC_URI="http://forchheimer.se/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXrender"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-ldflags.patch
	sed -i -e "/^CFLAGS/d" Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin transset-df
	dodoc ChangeLog README
}
