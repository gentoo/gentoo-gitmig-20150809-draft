# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latex2rtf/latex2rtf-1.9.14.ebuild,v 1.1 2004/02/26 19:05:41 usata Exp $

IUSE="doc"

DESCRIPTION="LaTeX to RTF converter"
HOMEPAGE="http://latex2rtf.sourceforge.net/"
SRC_URI="mirror://sourceforge/latex2rtf/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND="virtual/glibc
	virtual/tetex
	media-gfx/imagemagick"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-Makefile-gentoo.diff
}

src_compile() {
	emake CC=${CC} || die
}

src_install() {
	dodir /usr/share/doc/latex2rtf
	PREFIX=${D}/usr make -e install || die
	dodoc README doc/latex2rtf.txt
	# if doc is not used, only the text version is intalled.
	if use doc; then
		dodoc doc/latex2rtf.html doc/latex2rtf.pdf doc/latex2rtf.txt
		doinfo doc/latex2rtf.info
	fi
}
