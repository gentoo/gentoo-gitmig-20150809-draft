# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/d0_blind_id/d0_blind_id-0.3.ebuild,v 1.4 2011/10/19 20:46:18 hwoarang Exp $

EAPI=4
inherit autotools-utils

DESCRIPTION="Blind-ID library for user identification using RSA blind signatures"
HOMEPAGE="http://git.xonotic.org/?p=xonotic/d0_blind_id.git;a=summary"
SRC_URI="https://github.com/downloads/divVerent/d0_blind_id/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static-libs"

RDEPEND="dev-libs/gmp"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( d0_blind_id.txt )

src_configure() {
	econf \
		--enable-rijndael \
		--without-openssl \
		--without-tommath \
		$(use_enable static-libs static)
}

src_install() {
	autotools-utils_src_install
}
