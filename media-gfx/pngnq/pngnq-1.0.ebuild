# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngnq/pngnq-1.0.ebuild,v 1.2 2010/01/17 22:32:13 hanno Exp $

EAPI=2

inherit eutils autotools

DESCRIPTION="Pngnq is a tool for quantizing PNG images in RGBA format."
HOMEPAGE="http://pngnq.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libpng"

src_prepare() {
	epatch "${FILESDIR}/pngnq-1.0-as-needed.patch"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README NEWS || die "dodoc failed"
}
