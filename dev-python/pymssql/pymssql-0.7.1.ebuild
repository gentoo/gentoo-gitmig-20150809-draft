# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymssql/pymssql-0.7.1.ebuild,v 1.1 2005/12/18 04:11:37 lordvan Exp $

inherit distutils

DESCRIPTION="Simple MSSQL python extension module"
HOMEPAGE="http://pymssql.sourceforge.net/"
SRC_URI="mirror://sourceforge/pymssql/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
		>=dev-db/freetds-0.62.3"

post_install() {
	ewarn "freetds needs to be emerged with USE='mssql' for this to work."
	ewarn "The Projects webpage suggests using >=python-2.4."
	einfo "If you encounter problems with this ebuild and python-2.3 please"
	einfo "try with python 2.4 and let me know the outcome."
}
## freetds needs to be emerged with USE='mssql'
