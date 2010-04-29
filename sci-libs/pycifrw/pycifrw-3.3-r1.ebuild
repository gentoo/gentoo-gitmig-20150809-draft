# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/pycifrw/pycifrw-3.3-r1.ebuild,v 1.1 2010/04/29 14:57:02 jlec Exp $

SUPPORT_PYTHON_ABIS="1"

inherit distutils

PYTHON_MODNAME="CifFile.py StarFile.py yapps3_compiled_rt.py YappsStarParser_1_0.py YappsStarParser_1_1.py YappsStarParser_DDLm.py"
MY_PN="PyCifRW"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Provides support for reading and writing of CIF using python"
HOMEPAGE="http://pycifrw.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${MY_P}.tar.gz"

LICENSE="ASRP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"
