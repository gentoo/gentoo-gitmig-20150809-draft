# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/crossfire-client/crossfire-client-1.7.0.ebuild,v 1.2 2004/06/24 23:12:18 agriffis Exp $

inherit eutils games

DESCRIPTION="Client for the nethack-style but more in the line of UO"
HOMEPAGE="http://crossfire.real-time.com/"
SRC_URI="mirror://sourceforge/crossfire/${P}.tar.gz"

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
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:man1:man6:' \
		-e '/mandir/s:\.1:.6:' \
		{gtk,x11}/Makefile.in
}

src_compile() {
	# bugs in configure script so we cant use `use_enable`
	local myconf=""
	use gtk || myconf="${myconf} --disable-gtk"
	use sdl || myconf="${myconf} --disable-sdl"
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
	egamesinstall mandir=${D}/usr/share/man/man6 || die
	dodoc CHANGES NOTES README TODO
	prepgamesdirs
}
