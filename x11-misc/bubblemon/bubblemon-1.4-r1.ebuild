# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bubblemon/bubblemon-1.4-r1.ebuild,v 1.17 2005/03/19 15:23:58 luckyduck Exp $

DESCRIPTION="A fun monitoring applet for your desktop, complete with swimming duck"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 sparc ppc"

S=${WORKDIR}/${PN}-dockapp-${PV}
SRC_URI="http://www.ne.jp/asahi/linux/timecop/software/${PN}-dockapp-${PV}.tar.gz"
DEPEND="virtual/libc =x11-libs/gtk+-1.2*
	>=sys-apps/sed-4"

src_compile() {
	sed -i "s/CFLAGS = -O3/CFLAGS = ${CFLAGS}/" Makefile
	make || die
}

src_install () {
	into /usr
	dobin bubblemon
	dodoc INSTALL ChangeLog README doc/* misc/*
}
