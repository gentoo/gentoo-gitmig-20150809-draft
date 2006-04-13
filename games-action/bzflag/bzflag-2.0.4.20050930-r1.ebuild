# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/bzflag/bzflag-2.0.4.20050930-r1.ebuild,v 1.5 2006/04/13 19:40:07 wolf31o2 Exp $

inherit eutils flag-o-matic games

DESCRIPTION="OpenGL accelerated 3d tank combat simulator game"
HOMEPAGE="http://www.BZFlag.org/"
SRC_URI="mirror://sourceforge/bzflag/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="dedicated"

DEPEND=">=net-misc/curl-7.15.0
	sys-libs/ncurses
	net-dns/c-ares
	!dedicated? (
		virtual/opengl
		media-libs/libsdl )"

pkg_setup() {
	games_pkg_setup
	# comment in bug #107792
	# only do the libsdl checks for !dedicated
	use dedicated || GAMES_USE_SDL="nojoystick"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-callsignfix.patch
	sed -i \
		-e 's:^CFLAGS=.*::' \
		-e 's:^CXXFLAGS=.*::' \
		-e 's:-mcpu=$host_cpu::' \
		-e 's:-mtune=$host_cpu::' \
		-e 's:-ffast-math -fno-exceptions -fsigned-char::' \
		configure \
		|| die "sed failed"
	filter-flags -fno-default-inline
}

src_compile() {
	local myconf

	if use dedicated ; then
		ewarn
		ewarn "You are building a server-only copy of BZFlag"
		ewarn
		myconf="--disable-client --without-SDL"
	fi
	egamesconf \
		--disable-dependency-tracking \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS TODO ChangeLog BUGS PORTING DEVINFO NEWS README* RELNOTES

	if ! use dedicated ; then
		doicon "data/bzflag-48x48.png"
		make_desktop_entry ${PN} "BZFlag" ${PN}-48x48.png
	fi
	prepgamesdirs
}
