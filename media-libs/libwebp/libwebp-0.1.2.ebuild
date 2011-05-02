# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libwebp/libwebp-0.1.2.ebuild,v 1.2 2011/05/02 15:55:10 jer Exp $

EAPI=4
inherit autotools

DESCRIPTION="A lossy image compression format"
HOMEPAGE="http://code.google.com/p/webp/"
SRC_URI="http://webp.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="static-libs"

RDEPEND=">=media-libs/libpng-1.4
	virtual/jpeg"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--disable-dependency-tracking
}

src_install() {
	default
	find "${D}" -name '*.la' -exec rm -f {} +
}
