# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/frozen-bubble/frozen-bubble-1.0.0-r2.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

inherit games perl-module

NET_CLIENT_P=frozen-bubble-client-0.0.3
NET_SERVER_P=frozen-bubble-server-0.0.3
DESCRIPTION="A Puzzle Bubble clone written in perl (now with network support)"
HOMEPAGE="http://www.frozen-bubble.org/ http://chl.tuxfamily.org/frozen-bubble/"
SRC_URI="http://guillaume.cottenceau.free.fr/fb/${P}.tar.bz2
	http://chl.tuxfamily.org/frozen-bubble/${NET_CLIENT_P}.tar.bz2
	http://chl.tuxfamily.org/frozen-bubble/${NET_SERVER_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/glibc
	>=sys-apps/sed-4
	>=dev-lang/perl-5.6.1
	>=media-libs/sdl-mixer-1.2.3
	>=dev-perl/sdl-perl-1.19.0"

src_unpack() {
	unpack ${A}

	sed -i -e 's:INSTALLDIRS=.*:PREFIX=${D}/usr:' \
		${P}/c_stuff/Makefile \
		|| die 'sed c_stuff/Makefile failed'
}

src_compile() {
	make OPTIMIZE="${CFLAGS}" PREFIX=/usr/games || die

	cd ${WORKDIR}/${NET_SERVER_P}
	./bootstrap.sh || die
	econf || die
}

src_install() {
	make PREFIX=${D}/usr/games install || die
	dosed /usr/games/bin/frozen-bubble
	dodoc AUTHORS CHANGES COPYING README

	cd ${WORKDIR}/${NET_CLIENT_P}
	make PREFIX=${D}/usr/games install || die

	cd ${WORKDIR}/${NET_SERVER_P}
	make DESTDIR=${D} install || die
	dodoc TODO
	newdoc README README.server

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
}
