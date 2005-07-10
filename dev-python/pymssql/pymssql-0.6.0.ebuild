# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymssql/pymssql-0.6.0.ebuild,v 1.2 2005/07/10 01:13:39 swegener Exp $

inherit distutils

DESCRIPTION="Simple MSSQL python extension module"
HOMEPAGE="http://pymssql.sourceforge.net/"
SRC_URI="mirror://sourceforge/pymssql/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"
IUSE=""

DEPEND=">=dev-lang/python-2.2
		>=dev-db/freetds-0.62.3
		>=dev-db/unixODBC-2.2.8"

## freetds needs to be emerged with USE='mssql'
