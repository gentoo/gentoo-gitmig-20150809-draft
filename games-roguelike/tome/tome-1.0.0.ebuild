# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/tome/tome-1.0.0.ebuild,v 1.2 2004/01/02 08:00:00 vapier Exp $

IUSE="X"

S=${WORKDIR}/tome100-src

DESCRIPTION="A roguelike game, where you can save the world from Morgoth and battle evil(or become evil;)"
LICENSE="Moria"
SLOT="0"
KEYWORDS="x86"
SRC_URI="http://t-o-m-e.net/dl/src/tome-100-src.tgz"
HOMEPAGE="http://t-o-m-e.net/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5
	X? ( >=x11-base/xfree-4.0 )"

src_unpack() {
	unpack tome-100-src.tgz
	cd ${S}
}

src_compile() {
	cd ${S}/src
	emake -f makefile.org BINDIR=/usr/bin LIBDIR=/usr/share/tome/lib || die
}

src_install () {
	cd ${S}/src
	make -f makefile.org BINDIR=${D}/usr/bin LIBDIR=${D}/usr/share/tome/lib install || die
}
