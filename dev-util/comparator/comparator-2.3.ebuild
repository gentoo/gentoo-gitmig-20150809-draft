# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/comparator/comparator-2.3.ebuild,v 1.1 2004/01/21 11:15:59 robbat2 Exp $

inherit distutils
DESCRIPTION="ESR's utility for making fast comparisons among large source trees"
HOMEPAGE="http://www.catb.org/~esr/comparator/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	 http://www.catb.org/~esr/comparator/${P}.tar.gz"
LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~mips"
IUSE=""
#DEPEND='' inherit handles this
DEPEND="${DEPEND} app-text/xmlto"
RDEPEND="${RDEPEND}" #becase I don't want xmlto in here

src_unpack() {
	unpack ${A}
	# we will do this ourselves
	sed -e '/python setup.py install/d' -i ${S}/Makefile
	# Fix the Makefile to accept our CFLAGS
	sed -e "s/CFLAGS  = -O3/CFLAGS  = ${CFLAGS}/" -i ${S}/Makefile
}

src_compile() {
	distutils_src_install 
	emake || die "emake failed"
	emake comparator.html scf-standard.html || die "emake docs failed"
}

src_install() {
	distutils_src_install 
	einstall ROOT=${D} install || die "einstall failed"
	dohtml *.html
}
