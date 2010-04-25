# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mmtk/mmtk-2.7.1.ebuild,v 1.1 2010/04/25 10:29:25 jlec Exp $

EAPI="2"

PYTHON_MODNAME=${MY_PN}
SUPPORT_PYTHON_ABIS="1"

inherit distutils

# This number identifies each release on the CRU website.
# Can't figure out how to avoid hardcoding it.
NUMBER="2936"

MY_PN=${PN/mmtk/MMTK}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Molecular Modeling ToolKit for Python"
HOMEPAGE="http://dirac.cnrs-orleans.fr/MMTK/"
SRC_URI="http://sourcesup.cru.fr/frs/download.php/${NUMBER}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="CeCILL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-python/scientificpython-2.6"
DEPEND="${RDEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	sed -i -e "/ext_package/d" \
		"${S}"/setup.py \
		|| die
	distutils_src_prepare
}

src_install() {
	distutils_src_install

	dodoc README* Doc/CHANGELOG || die
	dohtml -r Doc/{HTML,Reference} || die

	insinto /usr/share/doc/${PF}/pdf
	doins Doc/PDF/manual.pdf || die
}
