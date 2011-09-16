# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/d0_blind_id/d0_blind_id-0.3.ebuild,v 1.1 2011/09/16 18:37:45 mr_bones_ Exp $

EAPI=4
inherit autotools-utils

DESCRIPTION="Blind-ID library for user identification using RSA blind signatures"
HOMEPAGE="http://git.xonotic.org/?p=xonotic/d0_blind_id.git;a=summary"
SRC_URI="https://github.com/downloads/divVerent/d0_blind_id/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl static-libs tommath"
REQUIRED_USE="ssl? ( !tommath )"

RDEPEND="ssl? ( !tommath? ( dev-libs/gmp ) )
	ssl? ( dev-libs/openssl )
	tommath? ( dev-libs/libtommath )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( d0_blind_id.txt )

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-rijndael \
		$(use_with ssl openssl) \
		$(use_with tommath) \
		$(use_enable static-libs static)
}

src_install() {
	autotools-utils_src_install
}
