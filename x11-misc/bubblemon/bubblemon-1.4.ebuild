# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bubblemon/bubblemon-1.4.ebuild,v 1.2 2001/08/30 18:59:56 woodchip Exp $

DESCRIPTION="A fun monitoring applet for your desktop, complete with swimming duck"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop"

S=${WORKDIR}/${PN}-dockapp-${PV}
SRC_URI="http://www.ne.jp/asahi/linux/timecop/software/${PN}-dockapp-${PV}.tar.gz"
DEPEND=">=x11-libs/gtk+-1.2.8"

src_compile() {

	# respect users CFLAGS and enable a neat feature turned off by default
	sed -e "s/CFLAGS = -O3/CFLAGS = ${CFLAGS}/" \
	    -e "s/# EXTRA += -DUPSIDE_DOWN_DUCK/EXTRA += -DUPSIDE_DOWN_DUCK/" \
	    Makefile | cat > Makefile
	make || die
}

src_install () {

	into /usr/X11R6
	dobin bubblemon
	# im putting the extra goodies in with docs. *very* small :)
	dodoc INSTALL ChangeLog README doc/* misc/*
}
