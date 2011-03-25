# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyodbc/pyodbc-2.1.8.ebuild,v 1.1 2011/03/25 15:07:11 neurogeek Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="python ODBC module to connect to almost any database"
HOMEPAGE="http://code.google.com/p/pyodbc"
SRC_URI="http://pyodbc.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mssql"

DEPEND=">=dev-db/unixODBC-2.3.0"
RDEPEND="${DEPEND}
	mssql? ( >=dev-db/freetds-0.64[odbc] )"

RESTRICT_PYTHON_ABIS="3.*"
