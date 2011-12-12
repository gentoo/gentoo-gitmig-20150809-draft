# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libwebp/libwebp-0.1.3.ebuild,v 1.2 2011/12/12 13:18:28 jer Exp $

EAPI=4

DESCRIPTION="A lossy image compression format"
HOMEPAGE="http://code.google.com/p/webp/"
SRC_URI="http://webp.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="static-libs"

RDEPEND=">=media-libs/libpng-1.4:0
	virtual/jpeg"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README )

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	find "${D}" -name '*.la' -exec rm -f {} +
}
