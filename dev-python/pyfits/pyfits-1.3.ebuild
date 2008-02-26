# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfits/pyfits-1.3.ebuild,v 1.1 2008/02/26 12:45:25 bicatali Exp $

NEED_PYTHON=2.3
inherit distutils

DESCRIPTION="Provides an interface to FITS formatted files under python"
SRC_URI="http://www.stsci.edu/resources/software_hardware/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/pyfits"

RDEPEND=">=dev-python/numpy-1.0.1"
DEPEND="test? ( >=dev-python/numpy-1.0.1 )"

IUSE="doc test"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
LICENSE="AURA"

src_test() {
	cd "${S}"/test
	for t in test*.py; do
		PYTHONPATH="${S}"/build/lib ${python} ${t} || die "test ${t} failed"
	done
}

src_install() {
	distutils_src_install
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins docs/Users_Manual.pdf || die
	fi
}
