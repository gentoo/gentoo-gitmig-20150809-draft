# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mhwaveedit/mhwaveedit-1.4.1.ebuild,v 1.1 2005/07/13 20:26:16 smithj Exp $

IUSE="gtk2 oss sdl"

DESCRIPTION="GTK2 Sound file editor (wav, and a few others.)"

# homepage and src_uri are dead. the source was pulled from fbsd's archives
SRC_URI="ftp://ftp.freebsd.org/pub/FreeBSD/ports/distfiles/${P}.tar.bz2"
HOMEPAGE="http://www.mtek.chalmers.se/~hjormagn/mhwaveedit.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~sparc ~x86"

DEPEND="gtk2? ( =x11-libs/gtk+-2* )
	!gtk2? ( =x11-libs/gtk+-1.2* )
	sdl? ( >=media-libs/libsdl-1.2.3 )
	>=media-libs/libsndfile-1.0.10
	>=media-libs/portaudio-18"

src_compile() {
	econf \
		$(use_enable gtk2) \
		$(use_with oss) \
		$(use_with sdl) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc ChangeLog AUTHORS README* NEWS BUGS
}
