# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/tome/tome-2.2.1.ebuild,v 1.1 2003/09/10 04:59:58 vapier Exp $

MY_PV=${PV//./}
S="${WORKDIR}/tome-${MY_PV}-src"

DESCRIPTION="A roguelike game, where you can save the world from Morgoth and battle evil (or become evil ;])"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"
SRC_URI="http://t-o-m-e.net/dl/src/tome-${MY_PV}-src.tgz"
HOMEPAGE="http://t-o-m-e.net/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5
	>=x11-base/xfree-4.0"

src_unpack() {
	unpack ${A}
	cd ${S}/src && \
	sed -i \
		-e "s:-O1:${CFLAGS}:" \
		makefile.std || die "sed makefile.std failed"
}

src_compile() {
	cd src && \
	make -f makefile.std \
		BINDIR=/usr/games/bin \
		LIBDIR=/usr/share/games/tome/lib || die "make failed"
}

src_install() {
	cd ${S}/src && \
	make -f makefile.std \
		BINDIR=${D}/usr/games/bin \
		LIBDIR=${D}/usr/share/games/tome/lib install || \
			die "make install failed"
	cd ${S} && \
	dodoc *.txt || die "dodoc failed"
}

pkg_postinst() {
	echo
	ewarn "ToME 2.2.1 is not save-game compatible with previous versions."
	echo
	einfo "If you have older save files and you wish to continue those games,"
	einfo "you'll need to remerge the version of ToME with which you started"
	einfo "those save-games."
	echo

	games_pkg_postinst
}
