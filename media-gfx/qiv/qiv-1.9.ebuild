# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qiv/qiv-1.9.ebuild,v 1.9 2006/09/03 09:00:54 kloeri Exp $

DESCRIPTION="Quick Image Viewer"
SRC_URI="http://www.klografx.net/qiv/download/${P}-src.tgz"
HOMEPAGE="http://www.klografx.net/qiv/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ppc64 ~sparc ~x86"

DEPEND="media-libs/libpng
	>=media-libs/tiff-3.5.5
	>=media-libs/imlib-1.9.14
	virtual/x11"

src_compile() {
	emake || die
}

src_install () {
	into /usr
	dobin qiv
	doman qiv.1
	dodoc README*
}
