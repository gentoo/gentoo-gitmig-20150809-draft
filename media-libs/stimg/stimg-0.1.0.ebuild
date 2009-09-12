# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/stimg/stimg-0.1.0.ebuild,v 1.8 2009/09/12 12:22:25 ssuominen Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="Simple and tiny image loading library"
HOMEPAGE="http:///homepage3.nifty.com/slokar/fb/"
SRC_URI="http://homepage3.nifty.com/slokar/stimg/${P}.tar.gz"

LICENSE="as-is LGPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc x86"
IUSE=""

RDEPEND="media-libs/libpng
	media-libs/jpeg
	media-libs/tiff"
DEPEND="${RDEPEND}"

src_configure() {
	tc-export CC
	econf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README.ja
}
