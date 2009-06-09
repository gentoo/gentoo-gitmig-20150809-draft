# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/comparator/comparator-2.5.ebuild,v 1.3 2009/06/09 20:25:40 fmccor Exp $

inherit distutils toolchain-funcs

DESCRIPTION="ESR's utility for making fast comparisons among large source trees"
HOMEPAGE="http://www.catb.org/~esr/comparator/"
SRC_URI="http://www.catb.org/~esr/comparator/${P}.tar.gz"

LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND="app-text/xmlto
	sys-apps/sed"

src_unpack() {
	unpack ${A}
	# we will do this ourselves
	sed -e '/python setup.py install/d' \
		-i "${S}"/Makefile || die "sed failed"
}

src_compile() {
	distutils_src_install
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		CC="$(tc-getCC)" || die "emake failed"
	emake comparator.html scf-standard.html || die "emake html failed"
}

src_install() {
	distutils_src_install
	emake ROOT="${D}" install || die "emake install failed"
	dohtml *.html
}
