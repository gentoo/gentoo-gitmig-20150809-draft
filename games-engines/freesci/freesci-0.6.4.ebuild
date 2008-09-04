# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/freesci/freesci-0.6.4.ebuild,v 1.1 2008/09/04 16:25:41 nyhm Exp $

inherit eutils games

DESCRIPTION="Sierra script interpreter for your old Sierra adventures"
HOMEPAGE="http://freesci.linuxgames.com/"
SRC_URI="http://www-plan.cs.colorado.edu/creichen/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X ggi sdl"

DEPEND="media-libs/alsa-lib
	X? (
		x11-libs/libX11
		x11-libs/libXrender
		x11-libs/libXext
	)
	ggi? ( media-libs/libggi )
	sdl? ( media-libs/libsdl )"

pkg_setup() {
	games_pkg_setup
	if ! built_with_use --missing true media-libs/alsa-lib midi; then
		eerror "You need to build media-libs/alsa-lib with the midi USE flag."
		die "Missing midi USE flag on media-libs/alsa-lib"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^SUBDIRS =/s:desktop src conf debian:src:" \
		Makefile.in \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--with-Wall \
		--without-directfb \
		$(use_with X x) \
		$(use_with ggi) \
		$(use_with sdl) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	doicon desktop/${PN}.png
	make_desktop_entry ${PN} FreeSCI
	dodoc AUTHORS ChangeLog NEWS README README.Unix THANKS TODO
	prepgamesdirs
}
