# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/gcompris/gcompris-7.4.ebuild,v 1.1 2006/04/13 05:17:39 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="full featured educational application for children from 2 to 10"
HOMEPAGE="http://gcompris.net"
SRC_URI="mirror://sourceforge/gcompris/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
#IUSE="python " #doesn't like python-2.4
IUSE=""

RDEPEND="|| ( x11-libs/libXrandr virtual/x11 )
	>=dev-libs/glib-2.0
	=x11-libs/gtk+-2*
	>=gnome-base/libgnomecanvas-2.0.2
	media-libs/sdl-mixer
	media-libs/libsdl
	dev-libs/libxml2
	dev-libs/popt"
DEPEND="${RDEPEND}
	sys-apps/texinfo
	app-text/texi2html
	|| ( x11-libs/libXt virtual/x11 )"
RDEPEND="${RDEPEND}
	games-board/gnuchess"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^install-data-am/s/install-libgcomprisincludeHEADERS//' \
		src/gcompris/Makefile.in \
		|| die "sed failed"
}

src_compile() {
	export GNUCHESS="${GAMES_BINDIR}/gnuchess"
	# $(use_with python python /usr/bin/python) - doesn't seem to work with 2.4
	# $(use_enable sqlite) \ - needs python
	econf \
		--disable-dependency-tracking \
		--without-python \
		--disable-sqlite \
		|| die
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	prepgamesdirs
}
