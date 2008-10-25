# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngnq/pngnq-0.5.ebuild,v 1.4 2008/10/25 19:15:38 hanno Exp $

inherit eutils

DESCRIPTION="Pngnq is a tool for quantizing PNG images in RGBA format."
HOMEPAGE="http://pngnq.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz
	mirror://sourceforge/${PN}/${P}-makefile.patch"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/libpng"
S="${WORKDIR}/${PV}"

src_unpack() {
	unpack "${P}-src.tar.gz"
	cd "${S}"

	epatch "${DISTDIR}/${P}-makefile.patch"
	epatch "${FILESDIR}/${P}-cflags.diff"
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	rm -rf "${D}/usr/share/doc/pngnq/"
	dodoc README README.pngcomp || die "dodoc failed"
}
