# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/crossfire-client/crossfire-client-1.7.1.ebuild,v 1.1 2005/03/09 07:18:13 mr_bones_ Exp $

inherit games

DESCRIPTION="Client for the nethack-style but more in the line of UO"
HOMEPAGE="http://crossfire.real-time.com/"
SRC_URI="mirror://sourceforge/crossfire/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="alsa gtk sdl"

DEPEND="virtual/x11
	alsa? ( media-libs/alsa-lib )
	gtk? ( =x11-libs/gtk+-1.2*
		dev-libs/glib
		sdl? ( media-libs/libsdl
			media-libs/sdl-image )
	)
	media-libs/libpng
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:man1:man6:' \
		-e '/mandir/s:\.1:.6:' \
		{gtk,x11}/Makefile.in \
		|| die "sed failed"
}

src_compile() {
	# bugs in configure script so we cant use $(use_enable ...)
	local myconf="--disable-dependency-tracking"

	if use gtk ; then
		use sdl || myconf="${myconf} --disable-sdl"
	else
		myconf="${myconf} --disable-gtk"
	fi
	if ! use alsa ; then
		has_version '>=media-libs/alsa-lib-0.9' \
			&& myconf="${myconf} --disable-alsa9" \
			|| myconf="${myconf} --disable-alsa"
	fi
	egamesconf ${myconf} || die
	emake -j1 -C sound-src || die "sound building failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGES NOTES README TODO
	prepgamesdirs
}
