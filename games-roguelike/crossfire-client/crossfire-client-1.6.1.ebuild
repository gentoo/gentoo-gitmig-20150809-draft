# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/crossfire-client/crossfire-client-1.6.1.ebuild,v 1.2 2004/02/20 06:55:42 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="Client for the nethack-style but more in the line of UO"
HOMEPAGE="http://crossfire.real-time.com/"
SRC_URI="mirror://sourceforge/crossfire/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="sdl gnome gtk alsa"

DEPEND="virtual/x11
	sdl? ( media-libs/libsdl
		media-libs/sdl-image )
	gnome? ( gnome-base/gnome-libs
		media-libs/gdk-pixbuf )
	gtk? ( =x11-libs/gtk+-1* )
	alsa? ( media-libs/alsa-lib )
	media-libs/libpng"

src_compile() {
	# bugs in configure script so we cant use `use_enable`
	local myconf=""
	use gtk || myconf="${myconf} --disable-gtk"
	use sdl || myconf="${myconf} --disable-sdl"
	use alsa || myconf="${myconf} --disable-alsa"
	has_version '>=media-libs/alsa-lib-0.9' && myconf="${myconf} --disable-alsa --disable-sound"
#	use gnome || myconf="${myconf} --disable-gnome"
	egamesconf ${myconf} || die
	make || die
}

src_install() {
	egamesinstall mandir=${T} || die
	use gtk && newman gtk/gcfclient.man gcfclient.6
	use gnome && newman gnome/gnome-cfclient.man gnome-cfclient.6
	newman x11/cfclient.man cfclient.6
	dodoc CHANGES NOTES README TODO
	prepgamesdirs
}
