# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/frozen-bubble/frozen-bubble-1.0.0-r4.ebuild,v 1.3 2005/03/19 21:12:11 vapier Exp $

inherit eutils perl-module games

NET_CLIENT_P=frozen-bubble-client-0.0.3
NET_SERVER_P=frozen-bubble-server-0.0.3
DESCRIPTION="A Puzzle Bubble clone written in perl (now with network support)"
HOMEPAGE="http://www.frozen-bubble.org/ http://chl.tuxfamily.org/frozen-bubble/"
SRC_URI="http://guillaume.cottenceau.free.fr/fb/${P}.tar.bz2
	http://chl.tuxfamily.org/frozen-bubble/${NET_CLIENT_P}.tar.bz2
	http://chl.tuxfamily.org/frozen-bubble/${NET_SERVER_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc sparc x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.1
	>=media-libs/sdl-mixer-1.2.3
	dev-perl/sdl-perl"
DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# main package
	epatch "${FILESDIR}"/${PV}-sdl-perl-check.patch
	epatch "${FILESDIR}"/${PV}-no-chainreaction.patch
	epatch "${FILESDIR}"/${P}-sdl-perl-2.patch
	sed -i \
		-e 's:INSTALLDIRS=.*:PREFIX=${D}/usr:' \
		c_stuff/Makefile \
		|| die 'sed c_stuff/Makefile failed'

	# server addon
	cd "${WORKDIR}"/${NET_SERVER_P}
	sed -i \
		-e '/^dnl AM_CONFIG_HEADER/s:dnl ::' configure.in \
		|| die "sed configure.in failed"
	libtoolize -c -f || die "libtoolize failed"
	env \
		WANT_AUTOMAKE=1.4 \
		WANT_AUTOCONF=2.5 \
		./bootstrap.sh || die "bootstrap failed"
	echo '#include "config.h"' >> fb_serv.h

	# client addon
	cd "${WORKDIR}"/${NET_CLIENT_P}
	ln -s frozen-bubble-client frozen-bubble
	epatch "${FILESDIR}"/${P}-sdl-perl-2.patch
	rm frozen-bubble
}

src_compile() {
	emake \
		OPTIMIZE="${CFLAGS}" \
		PREFIX=/usr \
		BINDIR="${GAMES_BINDIR}" \
		DATADIR="${GAMES_DATADIR}" \
		MANDIR=/usr/share/man \
		|| die "emake game failed"

	cd "${WORKDIR}"/${NET_SERVER_P}
	egamesconf || die
	emake || die "emake server failed"
}

src_install() {
	make \
		PREFIX="${D}/usr" \
		BINDIR="${D}/${GAMES_BINDIR}" \
		DATADIR="${D}/${GAMES_DATADIR}" \
		MANDIR="${D}/usr/share/man" \
		install \
		|| die "make install failed"
	dosed /usr/games/bin/frozen-bubble
	dodoc AUTHORS CHANGES README

	cd "${WORKDIR}/${NET_CLIENT_P}"
	make \
		PREFIX="${D}/usr" \
		BINDIR="${D}/${GAMES_BINDIR}" \
		DATADIR="${D}/${GAMES_DATADIR}" \
		MANDIR="${D}/usr/share/man" \
		install \
		|| die "make install client failed"

	cd "${WORKDIR}/${NET_SERVER_P}"
	make \
		DESTDIR="${D}" \
		sbindir="${GAMES_BINDIR}" \
		install \
		|| die "make install server failed"
	dodoc TODO
	newdoc README README.server

	prepgamesdirs
}
