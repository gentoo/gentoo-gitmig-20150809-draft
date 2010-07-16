# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymssql/pymssql-1.0.2.ebuild,v 1.6 2010/07/16 09:21:43 fauli Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Simple MSSQL python extension module"
HOMEPAGE="http://pymssql.sourceforge.net/ http://code.google.com/p/pymssql/ http://pypi.python.org/pypi/pymssql"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""

DEPEND=">=dev-db/freetds-0.63[mssql]"
RDEPEND="${DEPEND}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

PYTHON_MODNAME="pymssql.py"
