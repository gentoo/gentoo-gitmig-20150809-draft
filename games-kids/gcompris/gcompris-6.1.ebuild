# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/gcompris/gcompris-6.1.ebuild,v 1.2 2004/08/29 12:47:06 dholm Exp $

inherit games eutils

DESCRIPTION="full featured educational application for children from 3 to 10"
HOMEPAGE="http://ofset.sourceforge.net/gcompris/"
SRC_URI="mirror://sourceforge/gcompris/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="python editor"

DEPEND="virtual/x11
	>=dev-libs/glib-2.0
	=x11-libs/gtk+-2*
	>=gnome-base/libgnomecanvas-2.0.2
	>=dev-python/gnome-python-2.0
	media-libs/sdl-mixer
	media-libs/libsdl
	dev-libs/libxml2
	dev-libs/popt
	games-board/gnuchess
	sys-apps/texinfo
	app-text/texi2html
	python? ( dev-lang/python )
	editor? (
		>=gnome-base/libgnome-1.96.0
		>=gnome-base/libgnomeui-1.96.0
	)"

src_compile() {
	export GNUCHESS="${GAMES_BINDIR}/gnuchess"
	econf \
		`use_with python python /usr/bin/python` \
		`use_with editor` \
		|| die
	emake -j1 || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
