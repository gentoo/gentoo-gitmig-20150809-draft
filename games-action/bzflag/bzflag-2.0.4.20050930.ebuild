# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/bzflag/bzflag-2.0.4.20050930.ebuild,v 1.1 2005/10/30 08:27:49 mr_bones_ Exp $

GAMES_USE_SDL="nojoystick"
inherit eutils flag-o-matic games

DESCRIPTION="OpenGL accelerated 3d tank combat simulator game"
HOMEPAGE="http://www.BZFlag.org/"
SRC_URI="mirror://sourceforge/bzflag/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dedicated"
# kerberos"

DEPEND=">=net-misc/curl-7.15.0
	sys-libs/ncurses
	net-dns/c-ares
	!dedicated? (
		virtual/opengl
		sdl? ( media-libs/libsdl ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp data/bzflag-48x48.png "${T}/bzflag.png"
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
#		$(use_with kerberos) \
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable threads) \
		$(use_with sdl SDL) \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS TODO ChangeLog BUGS PORTING DEVINFO NEWS README* RELNOTES

	if ! use dedicated ; then
		doicon "${T}/bzflag.png"
		make_desktop_entry bzflag "BZFlag"
	fi
	prepgamesdirs
}
