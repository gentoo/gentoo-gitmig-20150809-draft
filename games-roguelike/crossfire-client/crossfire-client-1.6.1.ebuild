# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/crossfire-client/crossfire-client-1.6.1.ebuild,v 1.3 2004/03/20 13:25:08 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Client for the nethack-style but more in the line of UO"
HOMEPAGE="http://crossfire.real-time.com/"
SRC_URI="mirror://sourceforge/crossfire/${P}.tar.gz
	mirror://gentoo/${P}.configure.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="sdl gtk alsa"

DEPEND="virtual/x11
	sdl? ( media-libs/libsdl
		media-libs/sdl-image )
	gtk? ( =x11-libs/gtk+-1.2*
		dev-libs/glib
	)
	alsa? ( media-libs/alsa-lib )
	media-libs/libpng
	sys-libs/zlib"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	unpack ${P}.configure.gz
	mv ${P}.configure configure
	chmod a+x configure
}

src_compile() {
	# bugs in configure script so we cant use `use_enable`
	local myconf=""
	use gtk || myconf="${myconf} --disable-gtk"
	use sdl || myconf="${myconf} --disable-sdl"
	use alsa || myconf="${myconf} --disable-alsa"
	has_version '>=media-libs/alsa-lib-0.9' \
		&& myconf="${myconf} --disable-alsa --disable-sound"
	egamesconf ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	egamesinstall mandir="${T}" || die
	use gtk && newman gtk/gcfclient.man gcfclient.6
	newman x11/cfclient.man cfclient.6
	dodoc CHANGES NOTES README TODO
	prepgamesdirs
}
