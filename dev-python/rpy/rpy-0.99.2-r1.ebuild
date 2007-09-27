# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rpy/rpy-0.99.2-r1.ebuild,v 1.1 2007/09/27 07:34:16 hawking Exp $

inherit distutils eutils

DESCRIPTION="RPy is a very simple, yet robust, Python interface to the R Programming Language."
HOMEPAGE="http://rpy.sourceforge.net/"
SRC_URI="mirror://sourceforge/rpy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="examples lapack"

DEPEND="virtual/python
	>=dev-lang/R-2.3
	dev-python/numeric
	lapack? ( virtual/lapack )"
RDEPEND="${DEPEND}"

src_unpack() {
	distutils_src_unpack

	# Fix lapack linking issue, bug 143396
	if use lapack; then
		sed -i \
			-e "s:Rlapack:lapack:" \
			setup.py || die "sed in setup.py failed"
	else
		sed -i \
			-e "s:'Rlapack'::" \
			setup.py || die "sed in setup.py failed"
	fi

	epatch "${FILESDIR}/${P}-version-detect.patch"
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi

	# add R libs to ld.so.conf
	doenvd "${FILESDIR}/90rpy"
}

pkg_postinst() {
	env-update
}
