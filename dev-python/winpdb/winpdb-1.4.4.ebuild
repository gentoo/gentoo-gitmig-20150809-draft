# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/winpdb/winpdb-1.4.4.ebuild,v 1.4 2010/07/08 12:21:25 arfrever Exp $

PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="Graphical Python debugger"
#HOMEPAGE="http://www.digitalpeers.com/pythondebugger/"
#SRC_URI="mirror://sourceforge/winpdb/${P}.tar.gz"
HOMEPAGE="http://winpdb.org/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 x86"
IUSE=""

DEPEND=">=dev-python/pycrypto-2.0.1"
RDEPEND="${DEPEND}
		=dev-python/wxpython-2.8*"
