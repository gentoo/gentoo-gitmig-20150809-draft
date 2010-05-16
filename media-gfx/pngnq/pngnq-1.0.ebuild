# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngnq/pngnq-1.0.ebuild,v 1.4 2010/05/16 19:31:43 hwoarang Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Pngnq is a tool for quantizing PNG images in RGBA format."
HOMEPAGE="http://pngnq.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="media-libs/libpng"

src_prepare() {
	epatch "${FILESDIR}"/${P}-as-needed.patch \
		"${FILESDIR}"/${P}-libpng14.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README NEWS || die
}
