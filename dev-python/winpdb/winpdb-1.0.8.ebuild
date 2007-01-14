# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/winpdb/winpdb-1.0.8.ebuild,v 1.1 2007/01/14 16:36:55 dev-zero Exp $

inherit distutils

DESCRIPTION="Graphical Python debugger with smart breakpoints, thread support, modifiable namespace, secure connections"
HOMEPAGE="http://www.digitalpeers.com/pythondebugger/"
SRC_URI="mirror://sourceforge/winpdb/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 ~x86"
IUSE=""

DEPEND=">=dev-python/pycrypto-2.0.1
	>=dev-python/wxpython-2.6.3.3"
RDEPEND="${DEPEND}"
