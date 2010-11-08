# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/stimg/stimg-0.1.0.ebuild,v 1.11 2010/11/08 23:20:19 maekke Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="Simple and tiny image loading library"
HOMEPAGE="http://homepage3.nifty.com/slokar/fb/"
SRC_URI="http://homepage3.nifty.com/slokar/stimg/${P}.tar.gz"

LICENSE="as-is LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE="linguas_ja static-libs"

RDEPEND="media-libs/libpng
	media-libs/tiff
	virtual/jpeg"
DEPEND="${RDEPEND}"

src_configure() {
	tc-export CC
	econf \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	find "${D}" -name '*.la' -delete

	dodoc AUTHORS
	use linguas_ja && dodoc README.ja
}
