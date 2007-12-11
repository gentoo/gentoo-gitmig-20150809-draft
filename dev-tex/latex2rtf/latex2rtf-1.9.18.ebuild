# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latex2rtf/latex2rtf-1.9.18.ebuild,v 1.2 2007/12/11 10:34:15 aballier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="LaTeX to RTF converter"
HOMEPAGE="http://latex2rtf.sourceforge.net/"
SRC_URI="mirror://sourceforge/latex2rtf/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
IUSE="doc test"

# It needs some german language support packages for the tests
DEPEND="virtual/tetex
	media-gfx/imagemagick
	test? ( || (
		dev-texlive/texlive-langgerman
		app-text/tetex
		app-text/ptex
		)
	)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-Makefile-gentoo.diff"
	epatch "${FILESDIR}/${PN}-1.9.16-direntry.patch"
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	emake PREFIX="${D}/usr" install || die "make install failed"
	dodoc README doc/latex2rtf.txt
	# if doc is not used, only the text version is intalled.
	if use doc; then
		dohtml doc/latex2rtf.html
		dodoc doc/latex2rtf.pdf doc/latex2rtf.txt
		sed -i "s/\r/\n/g" doc/latex2rtf.info
		doinfo doc/latex2rtf.info
	fi
}
