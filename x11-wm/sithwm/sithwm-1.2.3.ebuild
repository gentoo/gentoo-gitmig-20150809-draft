# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/sithwm/sithwm-1.2.3.ebuild,v 1.2 2012/09/25 16:20:36 xmw Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Minimalist Window Manager for X"
HOMEPAGE="http://sithwm.darkside.no/"
SRC_URI="http://sithwm.darkside.no/sn/sithwm-1.2.3.tgz"

LICENSE="GPL-1 as-is 9wm"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-warnings.patch
	sed -e 's|install -s|install|g' \
		-i Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}
