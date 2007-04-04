# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/winpdb/winpdb-1.1.2.ebuild,v 1.1 2007/04/04 19:11:38 lucass Exp $

NEED_PYTHON=2.3

inherit distutils

DESCRIPTION="Graphical Python debugger with smart breakpoints, thread support, modifiable namespace, secure connections"
HOMEPAGE="http://www.digitalpeers.com/pythondebugger/"
SRC_URI="mirror://sourceforge/winpdb/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

DEPEND=">=dev-python/pycrypto-2.0.1
	>=dev-python/wxpython-2.6.3.3"
RDEPEND="${DEPEND}"
