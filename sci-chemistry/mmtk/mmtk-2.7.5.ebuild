# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/mmtk/mmtk-2.7.5.ebuild,v 1.1 2012/03/21 11:45:27 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-*"

inherit distutils

DL_ID=3794
MY_PN=MMTK
MY_P=${MY_PN}-${PV}

PYTHON_MODNAME="${MY_PN}"

DESCRIPTION="The Molecular Modelling Toolkit"
HOMEPAGE="http://dirac.cnrs-orleans.fr/MMTK/"
SRC_URI="https://sourcesup.cru.fr/frs/download.php/${DL_ID}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="CeCILL-2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-python/numpy
	dev-python/scientificpython"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}
