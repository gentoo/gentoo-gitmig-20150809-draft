# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/indent/indent-2.2.9.ebuild,v 1.4 2003/06/30 23:14:03 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Indent program source files"
SRC_URI="mirror://gnu/indent/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc alpha"

DEPEND="virtual/glibc"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS COPYING NEWS README* 
}
