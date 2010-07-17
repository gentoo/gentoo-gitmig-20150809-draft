# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfits/pyfits-2.3.1.ebuild,v 1.3 2010/07/17 09:03:20 fauli Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Provides an interface to FITS formatted files under python"
SRC_URI="http://www.stsci.edu/resources/software_hardware/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/pyfits"

IUSE=""
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
LICENSE="BSD"

RDEPEND="dev-python/numpy"
DEPEND="${RDEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

src_test() {
	testing() {
		local t
		for t in lib/tests/testPyfits*.py; do
			PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib*)"  "$(PYTHON)" "${t}" || die "${t} failed with Python ${PYTHON_ABI}"
		done
	}
	python_execute_function testing
}
