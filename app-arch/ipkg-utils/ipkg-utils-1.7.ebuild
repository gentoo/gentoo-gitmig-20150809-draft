# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/ipkg-utils/ipkg-utils-1.7.ebuild,v 1.1 2004/08/24 23:18:34 solar Exp $

inherit distutils

DESCRIPTION="Tools for working with the ipkg binary package format"
HOMEPAGE="http://www.openembedded.org/"
SRC_URI="http://handhelds.org/download/packages/ipkg-utils/${P}.tar.gz"
LICENSE="GPL-2"
IUSE=""
SLOT="0"
KEYWORDS="~x86 ~mips ~arm"

DEPEND="dev-lang/python"

src_compile() {
	sed -i -e 's#^PREFIX=.*#PREFIX=/usr#' Makefile || die 'prefix fix failed'
	sed -i -e 's#$(PREFIX)#$(DESTDIR)$(PREFIX)#' Makefile || die 'destdir fix failed'
	sed -i -e '/^install:/s#^\(.*\)$#\1\n\tmkdir -p $(DESTDIR)$(PREFIX)/bin#' Makefile || die 'mkdir fix failed'
	sed -i -e '/python setup.py/d' Makefile || die 'sandbox fix failed'
	distutils_src_compile
	emake || die "emake failed"
}

src_install() {
	distutils_src_install
	make DESTDIR=${D} install || die
}
