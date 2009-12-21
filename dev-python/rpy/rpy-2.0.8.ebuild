# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rpy/rpy-2.0.8.ebuild,v 1.2 2009/12/21 03:37:08 arfrever Exp $

EAPI="2"

inherit distutils eutils

SLOT=2
MYPN=${PN}${SLOT}
MYP=${MYPN}-${PV}

DESCRIPTION="Python interface to the R Programming Language"
HOMEPAGE="http://rpy.sourceforge.net/ http://pypi.python.org/pypi/rpy2"
SRC_URI="mirror://sourceforge/${PN}/${MYP}.tar.gz"

LICENSE="GPL-2 LGPL-2.1 MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="doc examples"

RDEPEND=">=dev-lang/R-2.8
	dev-python/numpy
	!<=dev-python/rpy-1.0.2-r2"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="${MYPN}"
S="${WORKDIR}/${MYP}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.0.6-setup.patch
}

src_test() {
	cd build/lib*
	PYTHONPATH=. "${python}" rpy2/tests.py || die "tests failed"
}
