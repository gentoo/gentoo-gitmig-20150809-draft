# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngnq/pngnq-1.0.ebuild,v 1.1 2010/01/08 13:34:34 patrick Exp $

EAPI=2

inherit eutils autotools

DESCRIPTION="Pngnq is a tool for quantizing PNG images in RGBA format."
HOMEPAGE="http://pngnq.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
	# mirror://sourceforge/${PN}/${P}-makefile.patch"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libpng"

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	rm -rf "${D}/usr/share/doc/pngnq/"
	dodoc README || die "dodoc failed"
	doman pngnq.1
}
