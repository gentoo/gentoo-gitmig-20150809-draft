# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mmtk/mmtk-2.7.3.ebuild,v 1.2 2011/01/07 11:36:59 jlec Exp $

EAPI="2"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

# This number identifies each release on the CRU website.
# Can't figure out how to avoid hardcoding it.
NUMBER="3421"

MY_PN=${PN/mmtk/MMTK}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Molecular Modeling ToolKit for Python"
HOMEPAGE="http://dirac.cnrs-orleans.fr/MMTK/"
SRC_URI="http://sourcesup.cru.fr/frs/download.php/${NUMBER}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="CeCILL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples"

RDEPEND="
	>=dev-python/scientificpython-2.6
	dev-python/cython"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	export MMTK_USE_CYTHON="1"
	sed -i -e "/ext_package/d" \
		"${S}"/setup.py \
		|| die
	distutils_src_prepare
}

src_install() {
	distutils_src_install

	dodoc README* Doc/CHANGELOG || die
	dohtml -r Doc/HTML/* || die

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r Examples || die
# Needs to wait for EAPI=4
#		dodoc -r Doc/Examples || die
	fi
}

PYTHON_MODNAME="${MY_PN}"
