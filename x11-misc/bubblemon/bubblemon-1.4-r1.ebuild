# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bubblemon/bubblemon-1.4-r1.ebuild,v 1.7 2002/08/01 11:59:04 seemant Exp $

DESCRIPTION="A fun monitoring applet for your desktop, complete with swimming duck"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

S=${WORKDIR}/${PN}-dockapp-${PV}
SRC_URI="http://www.ne.jp/asahi/linux/timecop/software/${PN}-dockapp-${PV}.tar.gz"
DEPEND="virtual/glibc =x11-libs/gtk+-1.2*"

src_compile() {

	sed -e "s/CFLAGS = -O3/CFLAGS = ${CFLAGS}/" Makefile | cat > Makefile
	make || die
}

src_install () {

	into /usr
	dobin bubblemon
	dodoc INSTALL ChangeLog README doc/* misc/*
}
