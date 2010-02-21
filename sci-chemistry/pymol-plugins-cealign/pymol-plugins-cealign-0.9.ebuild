# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pymol-plugins-cealign/pymol-plugins-cealign-0.9.ebuild,v 1.4 2010/02/21 10:04:20 jlec Exp $

EAPI="3"

SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="The CE algorithm is a fast and accurate protein structure alignment algorithm."
HOMEPAGE="http://www.pymolwiki.org/index.php/Cealign"
SRC_URI="http://www.pymolwiki.org/images/0/03/Cealign-${PV}.zip"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~amd64 ~amd64-linux"
IUSE=""

DEPEND="
	dev-python/numpy
	~sci-chemistry/pymol-1.2.2"
RDEPEND=""
RESTRICT_PYTHON_ABIS="2.4 3.*"

S=${WORKDIR}/cealign-0.9

src_prepare() {
	python_copy_sources
}

src_install(){
	distutils_src_install

	installation() {
		insinto $(python_get_sitedir)/cealign
		doins qkabsch.py cealign.py || die

		cat > "${T}"/pymolrc <<- EOF
		run ${EPREFIX}/$(python_get_sitedir)/cealign/qkabsch.py
		run ${EPREFIX}/$(python_get_sitedir)/cealign/cealign.py
		EOF

		insinto $(python_get_sitedir)/pymol
		doins "${T}"/pymolrc || die
	}
	python_execute_function -s installation

	dodoc CHANGES doc/cealign.pdf || die
}
