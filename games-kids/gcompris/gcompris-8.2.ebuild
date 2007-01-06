# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/gcompris/gcompris-8.2.ebuild,v 1.2 2007/01/06 02:36:28 nyhm Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest
inherit autotools python games

DESCRIPTION="full featured educational application for children from 2 to 10"
HOMEPAGE="http://gcompris.net/"
SRC_URI="mirror://sourceforge/gcompris/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="python"

RDEPEND="x11-libs/libXrandr
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
	>=dev-libs/popt-1.5
	games-board/gnuchess"
DEPEND="${RDEPEND}
	sys-devel/gettext
	sys-apps/texinfo
	app-text/texi2html
	x11-libs/libXt"
RDEPEND="${RDEPEND}
	media-gfx/tuxpaint
	sci-electronics/gnucap"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's/-Werror//' \
		-e '/AM_CHECK_PYMOD(gnome.canvas/d' \
		configure.in \
		|| die "sed configure failed"
	sed -i \
		-e 's:libgcomprisinclude_HEADERS:noinst_HEADERS:' \
		src/gcompris/Makefile.am \
		|| die "sed failed"
	cp /usr/share/gettext/config.rpath .
	eautoreconf
}

src_compile() {
	python_version
	export GNUCHESS=${GAMES_BINDIR}/gnuchess
	econf \
		--disable-dependency-tracking \
		$(use_with python python /usr/bin/python${PYVER}) \
		$(use_enable python sqlite) \
		|| die
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	prepgamesdirs
}
