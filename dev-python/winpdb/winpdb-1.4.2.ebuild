# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/winpdb/winpdb-1.4.2.ebuild,v 1.1 2008/12/07 00:08:24 patrick Exp $

NEED_PYTHON=2.3

inherit distutils

DESCRIPTION="Graphical Python debugger"
#HOMEPAGE="http://www.digitalpeers.com/pythondebugger/"
#SRC_URI="mirror://sourceforge/winpdb/${P}.tar.gz"
HOMEPAGE="http://winpdb.org/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

DEPEND=">=dev-python/pycrypto-2.0.1"
RDEPEND="${DEPEND}
		=dev-python/wxpython-2.8*"
