# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/pyslsk/pyslsk-0.4.9b.ebuild,v 1.1 2002/12/17 21:29:58 blauwers Exp $
inherit virtualx

S="${WORKDIR}/${P}"

DESCRIPTION="Python based SoulSeek client"
HOMEPAGE="http://www.sensi.org/~ak/pyslsk/"
SRC_URI="http://www.sensi.org/~ak/pyslsk/${P}.tar.gz"

LICENSE="GNU"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -sparc64"

DEPEND="virtual/python
	x11-base/xfree
	x11-libs/gtk+
	>=x11-libs/wxGTK-2.3.2
	>=dev-python/wxPython-2.3.3.1"

src_compile() {
	export maketype="python setup.py build"
	virtualmake "$*" || die
}



src_install () {
	export maketype="python setup.py install --prefix=${D}/usr"
	virtualmake "$*" || die
	dodoc CHANGELOG COPYING INSTALL KNOWN_BUGS MAINTAINERS MANIFEST README TODO VERSION
}
