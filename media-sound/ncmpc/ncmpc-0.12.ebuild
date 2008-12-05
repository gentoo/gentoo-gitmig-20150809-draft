# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ncmpc/ncmpc-0.12.ebuild,v 1.1 2008/12/05 21:39:11 omp Exp $

EAPI="2"

DESCRIPTION="A ncurses client for the Music Player Daemon (MPD)"
HOMEPAGE="http://mpd.wikia.com/wiki/Client:Ncmpc"
SRC_URI="http://downloads.sourceforge.net/musicpd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="artist-screen colors debug +help-screen key-screen lirc lyrics-screen
mouse nls search-screen song-screen"

RDEPEND=">=dev-libs/glib-2.4
	dev-libs/popt
	sys-libs/ncurses
	lirc? ( app-misc/lirc )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_enable artist-screen) \
		$(use_enable colors) \
		$(use_enable debug) \
		$(use_enable help-screen) \
		$(use_enable key-screen) \
		$(use_enable lirc) \
		$(use_enable lyrics-screen) \
		$(use_enable mouse) \
		$(use_enable nls) \
		$(use_enable search-screen) \
		$(use_enable song-screen)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
