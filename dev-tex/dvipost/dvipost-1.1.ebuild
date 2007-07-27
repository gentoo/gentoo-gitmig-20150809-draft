# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/dvipost/dvipost-1.1.ebuild,v 1.1 2007/07/27 04:42:00 aballier Exp $

inherit latex-package eutils toolchain-funcs

DESCRIPTION="post processor for dvi files"
HOMEPAGE="http://efeu.cybertec.at/index_en.html"
SRC_URI="http://efeu.cybertec.at/dist/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/tetex"

src_compile() {
	local myconf=""
	local flags="${CFLAGS}"
	tc-export CC

	econf || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	dobin dvipost
	dosym /usr/bin/dvipost /usr/bin/pptex
	dosym /usr/bin/dvipost /usr/bin/pplatex

	insinto /usr/share/texmf/tex/latex/misc/
	insopts -m0644
	doins dvipost.sty

	dodoc dvipost.doc CHANGELOG NOTES README
	dohtml dvipost.html
	newman ${S}/dvipost.man dvipost.1
}
