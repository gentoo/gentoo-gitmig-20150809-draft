# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latex2rtf/latex2rtf-1.9.15-r1.ebuild,v 1.7 2004/08/27 23:06:43 kugelfang Exp $

inherit eutils gcc

DESCRIPTION="LaTeX to RTF converter"
HOMEPAGE="http://latex2rtf.sourceforge.net/"
SRC_URI="mirror://sourceforge/latex2rtf/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
SLOT="0"
IUSE="doc"

DEPEND="virtual/libc
	virtual/tetex
	media-gfx/imagemagick"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-Makefile-gentoo.diff
	epatch ${FILESDIR}/${P}-direntry.patch
}

src_compile() {
	emake CC=$(gcc-getCC) || die
}

src_install() {
	PREFIX=${D}/usr make -e install || die
	dodoc README doc/latex2rtf.txt
	# if doc is not used, only the text version is intalled.
	if use doc; then
		dohtml doc/latex2rtf.html
		dodoc doc/latex2rtf.pdf doc/latex2rtf.txt
		sed -i "s/\r/\n/g" doc/latex2rtf.info
		doinfo doc/latex2rtf.info
	fi
}
