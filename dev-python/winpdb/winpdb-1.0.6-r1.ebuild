# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/winpdb/winpdb-1.0.6-r1.ebuild,v 1.2 2006/04/01 19:19:43 agriffis Exp $

inherit distutils

DESCRIPTION="Graphical Python debugger with smart breakpoints, thread support, modifiable namespace, secure connections"
HOMEPAGE="http://www.digitalpeers.com/pythondebugger/"
SRC_URI="mirror://sourceforge/winpdb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 ~x86"

IUSE=""
DEPEND=">=dev-python/pycrypto-2.0.1
	>=dev-python/wxpython-2.6.0.0-r1"

src_unpack() {
	unpack ${A}
	cd ${S} || die "Failed to cd to ${S}"
	#Fix DOS line-endings:
	mv _winpdb.py tmpwinpdb.py
	mv _rpdb2.py tmprpdb2.py
	tr -d '\015' < tmpwinpdb.py > _winpdb.py
	tr -d '\015' < tmprpdb2.py > _rpdb2.py
}
