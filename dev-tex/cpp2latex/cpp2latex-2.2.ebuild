# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/cpp2latex/cpp2latex-2.2.ebuild,v 1.2 2003/08/07 03:32:58 vapier Exp $

inherit eutils

DESCRIPTION="A program to convert C++ code to LaTeX source"
HOMEPAGE="http://www.arnoldarts.de/cpp2latex.html" 
SRC_URI="http://www.arnoldarts.de/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc
	app-text/tetex"

src_unpack () {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/main.cpp.patch
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die make install failed
}
