# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/bzflag/bzflag-2.0.10.ebuild,v 1.1 2007/11/15 23:54:37 tupone Exp $

inherit eutils flag-o-matic games

DESCRIPTION="3D tank combat simulator game"
HOMEPAGE="http://www.bzflag.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dedicated sdl"

UIDEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/glew
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libXxf86vm"

DEPEND=">=net-misc/curl-7.15.0
	sys-libs/ncurses
	net-dns/c-ares
	sdl? ( ${UIDEPEND} )
	!sdl? ( !dedicated? ( ${UIDEPEND} ) )"

pkg_setup() {
	# Only do the libsdl checks for !dedicated - bug #107792
	use dedicated || GAMES_USE_SDL="nojoystick"
	games_pkg_setup
}

src_compile() {
	local myconf

	if use dedicated && ! use sdl ; then
		ewarn
		ewarn "You are building a server-only copy of BZFlag"
		ewarn
		myconf="--disable-client --without-SDL"
	fi
	egamesconf \
		--disable-dependency-tracking \
		--without-regex \
		${myconf} \
		|| die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS TODO ChangeLog BUGS PORTING DEVINFO NEWS README* RELNOTES

	if use sdl || ! use dedicated ; then
		doicon "data/bzflag-48x48.png"
		make_desktop_entry ${PN} "BZFlag" ${PN}-48x48.png
	fi

	prepgamesdirs
}
