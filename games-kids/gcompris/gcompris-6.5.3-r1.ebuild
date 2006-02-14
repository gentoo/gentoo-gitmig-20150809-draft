# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/gcompris/gcompris-6.5.3-r1.ebuild,v 1.2 2006/02/14 04:07:37 joshuabaergen Exp $

inherit eutils games

DESCRIPTION="full featured educational application for children from 2 to 10"
HOMEPAGE="http://gcompris.net"
SRC_URI="mirror://sourceforge/gcompris/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
#IUSE="python editor" #editor didn't compile for me.; doesn't like python-2.4
IUSE=""

RDEPEND="|| ( x11-libs/libXrandr virtual/x11 )
	>=dev-libs/glib-2.0
	=x11-libs/gtk+-2*
	>=gnome-base/libgnomecanvas-2.0.2
	media-libs/sdl-mixer
	media-libs/libsdl
	dev-libs/libxml2
	dev-libs/popt
	games-board/gnuchess
	editor? (
		>=gnome-base/libgnome-1.96.0
		>=gnome-base/libgnomeui-1.96.0
	)"
DEPEND="${RDEPEND}
	sys-apps/texinfo
	app-text/texi2html"

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
	# $(use_with editor) - editor didn't compile for me.
	# $(use_with python python /usr/bin/python) - doesn't seem to work with 2.4
	econf \
		--disable-dependency-tracking \
		--without-python \
		--without-editor \
		|| die
	emake -j1 || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	# Crashed for me
	rm -rf "${D}/usr/share/gcompris/boards/watercycle"*
	rm -f "${D}/usr/share/gcompris/boards/followline.xml"
	# mailing list reports crash
	rm -f "${D}/usr/share/gcompris/boards/click_on_letter.xml"
	use editor || rm -f "${D}/usr/share/applications/gcompris-edit.desktop"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	prepgamesdirs
}
