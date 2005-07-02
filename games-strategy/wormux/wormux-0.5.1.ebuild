# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/wormux/wormux-0.5.1.ebuild,v 1.1 2005/07/02 19:35:48 vapier Exp $

inherit eutils games

DESCRIPTION="A free Worms clone"
HOMEPAGE="http://www.wormux.org/"
SRC_URI="http://download.gna.org/wormux/${PN}-src-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="nls debug"

RDEPEND="virtual/opengl
	virtual/x11
	>=dev-games/clanlib-0.7
	=dev-cpp/libxmlpp-1*
	sys-devel/gettext
	>=media-libs/libsdl-1.2.4
	media-libs/sdl-gfx
	media-libs/libvorbis"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	if use nls ; then
		sed -i \
			-e '/^localedir =/s:=.*:=/usr/share/locale:' \
			po/Makefile.in || die "sed localedir"
	fi
}

src_compile() {
	egamesconf \
		$(use_enable nls) \
		$(use_enable debug) \
		|| die "egamesconf"
	emake || die "emake"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS README
	prepgamesdirs
}
