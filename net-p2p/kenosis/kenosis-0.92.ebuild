# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/kenosis/kenosis-0.92.ebuild,v 1.1 2005/01/11 21:55:03 pythonhead Exp $

inherit distutils

DESCRIPTION="Fully-distributed p2p RPC system built on top of XMLRPC/bittorrent"
HOMEPAGE="http://sourceforge.net/projects/kenosis"
SRC_URI="mirror://sourceforge/kenosis/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"

IUSE="X"
DEPEND="X? ( <dev-python/wxpython-2.5* )
	>=dev-lang/python-2.1"


src_compile() {
	mv kenosis_setup.py setup.py
	distutils_src_compile
}
