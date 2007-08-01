# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfits/pyfits-1.1.ebuild,v 1.2 2007/08/01 05:11:07 mr_bones_ Exp $

NEED_PYTHON=2.3
inherit distutils

DESCRIPTION="Provides an interface to FITS formatted files under python"
SRC_URI="http://www.stsci.edu/resources/software_hardware/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/pyfits"

RDEPEND="|| ( >=dev-python/numpy-1.0.1 dev-python/numarray )"
DEPEND="test? ( >=dev-python/numpy-1.0.1 )"

IUSE="doc test"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
LICENSE="AURA"

S="${WORKDIR}/${PN}"

src_test() {
	cd ${S}/test
	for t in test*.py; do
		PYTHONPATH=${S}/build/lib ${python} ${t} || die "test failed"
	done
}

src_install() {
	distutils_src_install
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins docs/Users_Manual.pdf
	fi
}
