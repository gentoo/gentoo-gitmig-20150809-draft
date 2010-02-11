# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mmtk/mmtk-2.6.1.ebuild,v 1.1 2010/02/11 22:31:19 jlec Exp $

EAPI=2

MY_PN=${PN/mmtk/MMTK}
MY_P=${MY_PN}-${PV}

PYTHON_MODNAME=${MY_PN}

inherit distutils

# This number identifies each release on the CRU website.
# Can't figure out how to avoid hardcoding it.
NUMBER="2716"

DESCRIPTION="Molecular Modeling ToolKit for Python"
HOMEPAGE="http://dirac.cnrs-orleans.fr/MMTK/"
SRC_URI="http://sourcesup.cru.fr/frs/download.php/${NUMBER}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="CeCILL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-python/scientificpython-2.6"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e "/ext_package/d" \
		"${S}"/setup.py \
		|| die
}

src_install() {
	distutils_src_install

	dodoc README* Doc/CHANGELOG || die
	dohtml -r Doc/{module_reference,users_guide} || die

	insinto /usr/share/doc/${PF}/pdf
	doins Doc/users_guide.pdf || die
}
