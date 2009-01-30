# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymssql/pymssql-1.0.0.ebuild,v 1.1 2009/01/30 07:50:12 lordvan Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="Simple MSSQL python extension module"
HOMEPAGE="http://pymssql.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-db/freetds-0.63"

pkg_setup() {
	if ! built_with_use dev-db/freetds mssql ; then
		eerror "Re-emerge freetds with USE=mssql"
		die "Re-emerge freetds with USE=mssql"
	fi
}
