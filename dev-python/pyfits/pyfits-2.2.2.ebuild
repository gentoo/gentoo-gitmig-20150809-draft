# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfits/pyfits-2.2.2.ebuild,v 1.2 2009/11/19 16:22:36 maekke Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Provides an interface to FITS formatted files under python"
SRC_URI="http://www.stsci.edu/resources/software_hardware/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/pyfits"

IUSE=""
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
LICENSE="AURA"

RDEPEND="dev-python/numpy"
DEPEND="${RDEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

src_test() {
	cd "${S}/test"

	testing() {
		local test
		for test in test*.py; do
			PYTHONPATH="$(ls -d ../build-${PYTHON_ABI}/lib*)" "$(PYTHON)" "${test}" || die "test ${test} failed with Python ${PYTHON_ABI}"
		done
	}
	python_execute_function testing
}
