# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dbutils/dbutils-0.9.4.ebuild,v 1.1 2007/10/21 07:29:22 robbat2 Exp $

inherit distutils

MY_PN="DBUtils"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Database connections for multi-threaded environments."
HOMEPAGE="http://www.webwareforpython.org/DBUtils"
SRC_URI="http://www.webwareforpython.org/downloads/DBUtils/${MY_P}.tar.gz"

LICENSE="OSL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

RDEPEND=">=dev-lang/python-2.4"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
