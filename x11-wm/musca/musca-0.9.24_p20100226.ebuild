# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/musca/musca-0.9.24_p20100226.ebuild,v 1.2 2011/02/02 21:34:00 radhermit Exp $

EAPI="2"

inherit eutils savedconfig toolchain-funcs

DESCRIPTION="A simple dynamic window manager for X, with features nicked from
ratpoison and dwm"
HOMEPAGE="http://aerosuidae.net/musca/"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="apis xlisten"

COMMON="x11-libs/libX11"
DEPEND="${COMMON} sys-apps/sed"
RDEPEND="
	${COMMON} x11-misc/dmenu
	apis? ( x11-misc/xbindkeys )
"

src_prepare() {
	epatch "${FILESDIR}"/${P/_p*}-make.patch

	local i
	for i in apis xlisten; do
		use ${i} || sed -e "s|${i}||g" -i Makefile
	done

	restore_config config.h
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	dobin musca || die "dobin failed"

	local i
	for i in xlisten apis; do
		if use ${i}; then
			dobin ${i} || die "dobin ${i} failed"
		fi
	done
	doman musca.1 || die "doman failed"
	save_config config.h
}
