# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libwebp/libwebp-0.1.ebuild,v 1.2 2011/03/27 14:36:09 ranger Exp $

EAPI=2

DESCRIPTION="A lossy image compression format"
HOMEPAGE="http://code.google.com/p/webp/"
SRC_URI="http://webp.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="static-libs"

RDEPEND=">=media-libs/libpng-1.4
	virtual/jpeg"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README

	find "${D}" -name '*.la' -exec rm -f {} +
}
