# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}
SRC_URI="http://www.hacom.nl/~richard/software/${P}.tar.gz"
HOMEPAGE="http://www.hacom.nl/~richard/software/xtoolwait.html"
DESCRIPTION="Xtoolwait notably decreases the startup time of an X session"
DEPEND="virtual/x11"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	xmkmf
	emake || die
}

src_install() {
	dobin xtoolwait
	mv xtoolwait.man xtoolwait.1
	doman xtoolwait.1
	dodoc README CHANGES COPYING-2.0
}

