# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# Maintainer: Vitaly Kushneriuk<vitaly@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmppp/wmppp-1.3.0.ebuild,v 1.2 2002/07/08 21:31:07 aliz Exp $

S=${WORKDIR}/wmppp.app/wmppp

DESCRIPTION="Network monitoring dock.app"
SRC_URI="http://web.cs.mun.ca/~gstarkes/wmaker/dockapps/files/${P}.tar.gz"
HOMEPAGE="http://www.linux.tucows.com"
DEPEND="virtual/glibc x11-base/xfree"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86

src_compile() {
	emake all || die
}

src_install () {
	dobin wmppp
	exeinto /etc/ppp
	doexe getmodemspeed
	dodoc user.wmppprc
	cd ..
	dodoc BUGS  CHANGES  COPYING  HINTS  INSTALL  README  TODO
}
