# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/bzflag/bzflag-2.4.0.ebuild,v 1.2 2011/08/04 03:33:59 mr_bones_ Exp $

EAPI=2
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
	media-libs/libsdl[audio,joystick,video]
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

src_configure() {
	local myconf

	if use dedicated && ! use sdl ; then
		ewarn
		ewarn "You are building a server-only copy of BZFlag"
		ewarn
		myconf="--disable-client --without-SDL"
	fi
	egamesconf \
		--disable-ccachetest \
		--disable-dependency-tracking \
		--without-regex \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS TODO ChangeLog BUGS PORTING DEVINFO NEWS README*

	if use sdl || ! use dedicated ; then
		newicon "data/bzflag-48x48.png" ${PN}.png
		make_desktop_entry ${PN} "BZFlag"
	fi

	prepgamesdirs
}
