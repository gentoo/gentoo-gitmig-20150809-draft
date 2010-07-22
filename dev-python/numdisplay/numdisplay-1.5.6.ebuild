# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numdisplay/numdisplay-1.5.6.ebuild,v 1.2 2010/07/22 16:40:15 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python package for interactively displaying FITS arrays"
HOMEPAGE="http://stsdas.stsci.edu/numdisplay/"
SRC_URI="http://stsdas.stsci.edu/${PN}/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/numpy"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_install() {
	distutils_src_install

	delete_LICENSE() {
		rm -f "${ED}$(python_get_sitedir)/${PN}/LICENSE.txt"
	}
	python_execute_function -q delete_LICENSE
}
