# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/musca/musca-0.9.23.ebuild,v 1.2 2009/09/26 16:13:16 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="A simple dynamic window manager for X, with features nicked from
ratpoison and dwm"
HOMEPAGE="http://aerosuidae.net/musca/"
SRC_URI="http://aerosuidae.net/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND} x11-misc/dmenu"

src_prepare() {
	epatch "${FILESDIR}/${P}-flags.patch"
}

src_compile() {
	tc-export CC
	default_src_compile
}

src_install() {
	dobin musca
	doman musca.1
}
