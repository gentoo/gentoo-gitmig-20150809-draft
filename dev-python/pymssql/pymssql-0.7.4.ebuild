# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymssql/pymssql-0.7.4.ebuild,v 1.7 2010/07/08 14:29:25 arfrever Exp $

PYTHON_DEPEND="2"

inherit eutils distutils

DESCRIPTION="Simple MSSQL python extension module"
HOMEPAGE="http://pymssql.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""

DEPEND=">=dev-db/freetds-0.63"

pkg_setup() {
	if ! built_with_use dev-db/freetds mssql ; then
		eerror "Re-emerge freetds with USE=mssql"
		die "Re-emerge freetds with USE=mssql"
	fi
}
