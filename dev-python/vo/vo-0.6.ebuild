# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/vo/vo-0.6.ebuild,v 1.2 2010/09/10 21:50:56 arfrever Exp $

EAPI=3

PYTHON_DEPEND="*:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils

DESCRIPTION="Python module to read VOTABLE into a Numpy recarray"
HOMEPAGE="https://trac6.assembla.com/astrolib/wiki http://www.scipy.org/AstroLib"
SRC_URI="http://stsdas.stsci.edu/astrolib/${P}.tar.gz"

IUSE="examples"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND="dev-libs/expat"
DEPEND="${RDEPEND}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	epatch "${FILESDIR}"/${P}-expat.patch
}

#FIXME: tests are buggy, sphinx misses stsci_sphinx.conf

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}/
		doins -r examples || die
	fi
}
