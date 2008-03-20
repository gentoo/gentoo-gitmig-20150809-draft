# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/comparator/comparator-2.5.ebuild,v 1.1 2008/03/20 15:52:07 rbu Exp $

inherit distutils toolchain-funcs
DESCRIPTION="ESR's utility for making fast comparisons among large source trees"
HOMEPAGE="http://www.catb.org/~esr/comparator/"
SRC_URI="http://www.catb.org/~esr/comparator/${P}.tar.gz"
LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"
IUSE=""
#DEPEND='' inherit handles this
DEPEND="${DEPEND} app-text/xmlto"
RDEPEND="${RDEPEND}" #becase I don't want xmlto in here

src_unpack() {
	unpack ${A}
	# we will do this ourselves
	sed -e '/python setup.py install/d' -i "${S}"/Makefile
	# Fix the Makefile to accept our CFLAGS
	sed -e "s/CFLAGS  = -O3/CFLAGS  = ${CFLAGS}/" -i "${S}"/Makefile
}

src_compile() {
	distutils_src_install
	emake CC="$(tc-getCC)" || die "emake failed"
	emake comparator.html scf-standard.html || die "emake docs failed"
}

src_install() {
	distutils_src_install
	emake ROOT="${D}" install || die "einstall failed"
	dohtml *.html
}
