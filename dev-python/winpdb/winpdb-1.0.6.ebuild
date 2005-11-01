# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/winpdb/winpdb-1.0.6.ebuild,v 1.1 2005/11/01 04:20:02 pythonhead Exp $

inherit distutils

DESCRIPTION="Graphical Python debugger with smart breakpoints, thread support, modifiable namespace, secure connections"
HOMEPAGE="http://www.digitalpeers.com/pythondebugger/"
SRC_URI="mirror://sourceforge/winpdb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=">=dev-python/pycrypto-2.0.1
	>=dev-python/wxpython-2.6.0.0-r1"

src_unpack() {
	unpack ${A}
	cd ${S} || die "Failed to cd to ${S}"
	echo "#!/usr/bin/python" > _winpdb.py
	echo "import winpdb" >> _winpdb.py
	echo "winpdb.main()" >> _winpdb.py
}
