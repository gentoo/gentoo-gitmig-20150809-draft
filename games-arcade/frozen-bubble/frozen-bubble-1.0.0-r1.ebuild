# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/frozen-bubble/frozen-bubble-1.0.0-r1.ebuild,v 1.2 2004/02/03 01:28:31 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="A Puzzle Bubble clone written in perl"
HOMEPAGE="http://www.frozen-bubble.org/"
SRC_URI="http://guillaume.cottenceau.free.fr/fb/${P}.tar.bz2"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc
	>=sys-apps/sed-4
	>=dev-lang/perl-5.6.1
	>=media-libs/sdl-mixer-1.2.3
	>=dev-perl/sdl-perl-1.19.0"

src_unpack() {
	unpack ${A}

	sed -i \
		-e 's:INSTALLDIRS=.*:PREFIX=${D}/usr:' \
		${P}/c_stuff/Makefile \
		|| die 'sed c_stuff/Makefile failed'
}

src_compile() {
	make OPTIMIZE="${CFLAGS}" PREFIX="/usr" || die
}

src_install() {
	make PREFIX="${D}/usr" install || die

	dosed /usr/bin/frozen-bubble
	dodoc AUTHORS CHANGES README
}
