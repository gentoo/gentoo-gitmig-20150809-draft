# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mhwaveedit/mhwaveedit-1.2.1.ebuild,v 1.1 2003/05/12 19:35:30 avenj Exp $

IUSE="gtk2 oss sdl"

DESCRIPTION="GTK2 Sound file editor (wav, and a few others.)"
SRC_URI="http://www.mtek.chalmers.se/~hjormagn/${P}.tar.gz"
HOMEPAGE="http://www.mtek.chalmers.se/~hjormagn/mhwaveedit.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="gtk2? ( >=x11-libs/gtk+-2.0.0 )
	!gtk2? ( =x11-libs/gtk+-1.2* )
	sdl? ( >=media-libs/libsdl-1.2.3 )
	>=media-libs/libsndfile-1.0.1
	>=media-libs/portaudio-18"

src_compile() {
	local myconf
	
	use gtk2 || myconf="${myconf} --disable-gtk2"

	use oss || myconf="${myconf} --without-oss"

	use sdl || myconf="${myconf} --withut-sdl"
	
	econf ${myconf} || die
	emake || die
}

src_install() {

	einstall || die

	dodoc COPYING ChangeLog AUTHORS README* NEWS BUGS
}
