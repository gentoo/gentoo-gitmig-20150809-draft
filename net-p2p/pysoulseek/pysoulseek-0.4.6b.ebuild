# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/pysoulseek/pysoulseek-0.4.6b.ebuild,v 1.4 2003/02/13 15:22:24 vapier Exp $

MY_PN="${PN/soulseek/slsk}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="client for SoulSeek filesharing"
HOMEPAGE="http://www.sensi.org/~ak/pyslsk/"
SRC_URI="http://www.sensi.org/~ak/pyslsk/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc "

DEPEND="=x11-libs/gtk+-1.2*
	>=dev-lang/python-2.1
	>=dev-python/wxPython-2.3.3.1-r1
	>=x11-libs/wxGTK-2.3.3"

S="${WORKDIR}/${MY_P}"

src_compile() {
	python setup.py build || die "compile failed"
}

src_install() {
	python setup.py install --prefix=/usr --root=${D} || die "install failed"
	dodoc CHANGELOG KNOWN_BUGS MAINTAINERS MANIFEST PKG-INFO README TODO VERSION
}
