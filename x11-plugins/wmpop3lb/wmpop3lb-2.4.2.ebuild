# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpop3lb/wmpop3lb-2.4.2.ebuild,v 1.6 2004/01/04 18:36:48 aliz Exp $

IUSE=""

MY_P=${PN}${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="dockapp for checking up to 7 pop3 accounts"
HOMEPAGE="http://wmpop3lb.jourdain.org"
SRC_URI="http://lbj.free.fr/wmpop3/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A} ; cd ${S}/wmpop3

	sed -i -e "s:-g2 -D_DEBUG:${CFLAGS}:" Makefile
}

src_compile() {
	emake -C wmpop3 || die "parallel make failed"
}

src_install() {
	dobin wmpop3/wmpop3lb
	dodoc CHANGE_LOG README
}
