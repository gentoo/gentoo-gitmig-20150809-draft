# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/cpp2latex/cpp2latex-2.3.ebuild,v 1.2 2004/04/01 16:52:21 jhuebel Exp $

# eutils is in portage proper now, no need to inherit

DESCRIPTION="A program to convert C++ code to LaTeX source"
HOMEPAGE="http://www.arnoldarts.de/cpp2latex.html"
SRC_URI="http://www.arnoldarts.de/${P}.tar.gz"
LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="x86 ppc amd64"

# although it makes sense to have tex installed, it is
# neither a compile or runtime dependency

src_compile() {

	econf || die
	emake || die

}

src_install() {

	make install DESTDIR=${D} || die

}
