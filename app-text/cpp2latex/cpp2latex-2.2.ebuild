# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/cpp2latex/cpp2latex-2.2.ebuild,v 1.1 2003/01/03 05:29:16 satai Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A program to convert C++ code to LaTeX source"
SRC_URI="http://www.arnoldarts.de/${P}.tar.gz"
HOMEPAGE="http://www.arnoldarts.de/cpp2latex.html" 

DEPEND="virtual/glibc
	app-text/tetex"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ppc"

src_unpack () {
	unpack ${A}
	cd ${S}
	patch -p 0 < ${FILESDIR}/main.cpp.patch
}

src_compile () {
	econf
	emake
}

src_install () {
    make install DESTDIR=${D} || die make install failed
}
