# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/tome/tome-2.0.0.ebuild,v 1.1 2003/09/10 04:59:58 vapier Exp $ 

MY_PV=${PV//./}
S="${WORKDIR}/tome-${MY_PV}-src"

DESCRIPTION="A roguelike game, where you can save the world from Morgoth and battle evil (or become evil ;])"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
SRC_URI="http://t-o-m-e.net/dl/src/tome-${MY_PV}-src.tgz"
HOMEPAGE="http://t-o-m-e.net/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5
	>=x11-base/xfree-4.0"

src_compile() {
	cd ${S}/src
	cp makefile.org makefile.org.old
	sed  -e "s:-O1:${CFLAGS}:" \
		makefile.org.old > makefile.org
	emake -f makefile.org BINDIR=/usr/bin LIBDIR=/usr/share/tome/lib || die "compile failed"
}

src_install () {
	cd ${S}/src
	make -f makefile.org BINDIR=${D}/usr/bin LIBDIR=${D}/usr/share/tome/lib install || die "install failed"
}
