# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/pycifrw/pycifrw-3.3.ebuild,v 1.1 2010/04/28 20:14:33 jlec Exp $

SUPPORT_PYTHON_ABIS="1"
PYTHON_MODNAME=""

inherit distutils

MY_PN="PyCifRW"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Provides support for reading and writing of CIF using python"
HOMEPAGE="http://pycifrw.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${MY_P}.tar.gz"

LICENSE="ASRP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"
