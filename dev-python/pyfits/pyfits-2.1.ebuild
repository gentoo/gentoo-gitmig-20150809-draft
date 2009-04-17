# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfits/pyfits-2.1.ebuild,v 1.1 2009/04/17 13:17:09 bicatali Exp $

NEED_PYTHON=2.3
inherit distutils

DESCRIPTION="Provides an interface to FITS formatted files under python"
SRC_URI="http://www.stsci.edu/resources/software_hardware/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/pyfits"

RDEPEND="dev-python/numpy"
DEPEND="${RDEPEND}"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
LICENSE="AURA"


src_test() {
	cd "${S}"/test
	for t in test*.py; do
		PYTHONPATH="$(dir -d ${S}/build/lib*)" "${python}" \
			${t} || die "test ${t} failed"
	done
}
