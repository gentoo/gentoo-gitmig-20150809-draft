# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-rrdtool/py-rrdtool-0.2.1.ebuild,v 1.1 2004/09/04 18:45:00 squinky86 Exp $

inherit distutils

IUSE=""
DESCRIPTION="Python wrapper for RRDtool"
SRC_URI="mirror://sourceforge/py-rrdtool/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/py-rrdtool/"

KEYWORDS="~x86"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="virtual/python
	net-analyzer/rrdtool"

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
}
