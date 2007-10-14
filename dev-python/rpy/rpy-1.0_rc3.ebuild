# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rpy/rpy-1.0_rc3.ebuild,v 1.1 2007/10/14 06:33:41 genstef Exp $

inherit distutils eutils

MY_P="${P/_rc/-RC}"
DESCRIPTION="RPy is a very simple, yet robust, Python interface to the R Programming Language."
HOMEPAGE="http://rpy.sourceforge.net/"
SRC_URI="mirror://sourceforge/rpy/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="examples lapack"

DEPEND=">=dev-lang/R-2.3
	dev-python/numpy
	lapack? ( virtual/lapack )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

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
			setup.py || die "sed in setup.py failed"
	fi

	epatch "${FILESDIR}/${P}-version-detect.patch"
	epatch "${FILESDIR}/${P}-lib-handling.patch"
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	# add R libs to ld.so.conf
	doenvd "${FILESDIR}/90rpy"
}

pkg_postinst() {
	elog "You'll have to run env-update in order to find the R libraries."
}
