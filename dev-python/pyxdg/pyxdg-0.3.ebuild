# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxdg/pyxdg-0.3.ebuild,v 1.2 2004/03/28 14:52:46 kloeri Exp $

inherit distutils

DESCRIPTION="a python module to deal with freedesktop.org specifications."
#SRC_URI="http://www.cojobo.net/~h_wendel/stuff/${P}.tar.gz"
SRC_URI="http://freedesktop.org/Software/pyxdg/releases/${P}.tar.gz"
HOMEPAGE="http://cvs.cojobo.net/cgi-bin/viewcvs.cgi/pyxdg/"
LICENSE="GPL-2"

DEPEND="virtual/python"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install () {
	distutils_src_install
	dodoc AUTHORS
	insinto /usr/share/doc/${P}
	doins doc/menu.dtd
	insinto /usr/share/doc/${P}/test
	doins test/test-menu.py test/test-desktop.py
}
