# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/musca/musca-0.9.24.ebuild,v 1.3 2009/11/30 20:46:34 jer Exp $

EAPI="2"

inherit eutils savedconfig toolchain-funcs

DESCRIPTION="A simple dynamic window manager for X, with features nicked from
ratpoison and dwm"
HOMEPAGE="http://aerosuidae.net/musca/"
SRC_URI="http://aerosuidae.net/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="apis xlisten"

COMMON="x11-libs/libX11"
DEPEND="${COMMON} sys-apps/sed"
RDEPEND="
	${COMMON} x11-misc/dmenu
	apis? ( x11-misc/xbindkeys )
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-make.patch

	local i
	for i in apis xlisten; do
		use ${i} || sed -e "s|${i}||g" -i Makefile
	done

	use savedconfig && restore_config config.h
}

src_compile() {
	use savedconfig && msg=", please check the saved config file"
	tc-export CC
	emake || die "emake failed${msg}"
}

src_install() {
	dobin musca xlisten || die "dobin failed"
	if use apis; then
		dobin apis || die "dobin failed"
	fi
	doman musca.1 || die "doman failed"
	save_config config.h
}
