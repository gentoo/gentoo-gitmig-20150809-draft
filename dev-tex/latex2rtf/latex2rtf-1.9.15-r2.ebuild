# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latex2rtf/latex2rtf-1.9.15-r2.ebuild,v 1.2 2004/11/06 08:11:08 usata Exp $

inherit eutils toolchain-funcs

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
	epatch ${FILESDIR}/${P}-definitions.c.diff
	epatch ${FILESDIR}/${PN}-Makefile-gentoo.diff
	epatch ${FILESDIR}/${P}-direntry.patch
}

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install() {
	make PREFIX=${D}/usr CC=$(tc-getCC) install || die
	dodoc README doc/latex2rtf.txt
	# if doc is not used, only the text version is intalled.
	if use doc; then
		dohtml doc/latex2rtf.html
		dodoc doc/latex2rtf.pdf doc/latex2rtf.txt
		sed -i "s/\r/\n/g" doc/latex2rtf.info
		doinfo doc/latex2rtf.info
	fi
}
