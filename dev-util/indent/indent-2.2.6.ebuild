# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/indent/indent-2.2.6.ebuild,v 1.7 2002/12/09 04:21:15 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Indent program source files"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="virtual/glibc"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS COPYING NEWS README* 
}
