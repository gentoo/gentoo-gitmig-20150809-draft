# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/gcompris/gcompris-7.4-r1.ebuild,v 1.1 2006/09/04 22:24:23 tupone Exp $

inherit eutils python games

DESCRIPTION="full featured educational application for children from 2 to 10"
HOMEPAGE="http://gcompris.net"
SRC_URI="mirror://sourceforge/gcompris/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="python"

RDEPEND="|| ( x11-libs/libXrandr virtual/x11 )
	>=dev-libs/glib-2.0
	=x11-libs/gtk+-2*
	>=gnome-base/libgnomecanvas-2.0.2
	media-libs/sdl-mixer
	media-libs/libsdl
	dev-libs/libxml2
	python? (
		dev-python/gnome-python
		dev-python/pygtk
		dev-python/pyxml
		>=dev-python/pysqlite-2
	)
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
	python_version
	export GNUCHESS="${GAMES_BINDIR}/gnuchess"
	econf \
		--disable-dependency-tracking \
		$(use_with python python /usr/bin/python${PYVER}) \
		$(use_enable python sqlite) \
		|| die
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	prepgamesdirs
}
