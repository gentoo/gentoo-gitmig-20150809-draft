# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpop3lb/wmpop3lb-2.4.2.ebuild,v 1.1 2002/10/08 14:43:18 raker Exp $

IUSE=""

VERSION=2.4.2
S=${WORKDIR}/wmpop3lb${VERSION}

DESCRIPTION="dockapp for checking up to 7 pop3 accounts"
HOMEPAGE="http://wmpop3lb.jourdain.org"
SRC_URI="http://lbj.free.fr/wmpop3/wmpop3lb${VERSION}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	virtual/x11
	x11-wm/WindowMaker"
RDEPEND="${DEPEND}"

src_unpack() {

	unpack ${A}
	cd ${S}/wmpop3

	mv Makefile Makefile.orig
	sed -e "s:-g2 -D_DEBUG:${CFLAGS}:" Makefile.orig > Makefile

}

src_compile() {

	emake -C wmpop3 || die "parallel make failed"

}

src_install() {

	dobin wmpop3/wmpop3lb

	dodoc CHANGE_LOG README

}
