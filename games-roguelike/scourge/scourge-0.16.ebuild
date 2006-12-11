# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/scourge/scourge-0.16.ebuild,v 1.2 2006/12/11 23:42:25 nyhm Exp $

inherit eutils wxwidgets games

DESCRIPTION="A graphical rogue-like adventure game"
HOMEPAGE="http://scourge.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.src.tar.gz
	mirror://sourceforge/${PN}/${P}.data.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="wxwindows"

DEPEND="x11-libs/libXmu
	x11-libs/libXi
	virtual/glu
	virtual/opengl
	>=media-libs/freetype-2
	>=media-libs/libsdl-1.2
	media-libs/sdl-net
	media-libs/sdl-mixer
	wxwindows? ( >=x11-libs/wxGTK-2.6 )"

S=${WORKDIR}/${PN}

pkg_setup() {
	games_pkg_setup
	use wxwindows && WX_GTK_VER="2.6" need-wxwidgets unicode
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	if use wxwindows ; then
		sed -i \
			-e "/WXWIDGET_CFLAGS/s:wx-config:${WX_CONFIG}:" \
			-e "/WXWIDGET_LIBS/s:wx-config:${WX_CONFIG}:" \
			configure || die "sed failed"
	fi
}

src_compile() {
	egamesconf \
		--with-data-dir="${GAMES_DATADIR}/${PN}" \
		$(use_enable wxwindows editor) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	use wxwindows && mv "${D}/${GAMES_BINDIR}"/{tools,${PN}-tools}
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r ../scourge_data/* || die "doins failed"
	doicon assets/scourge.png
	make_desktop_entry scourge S.C.O.U.R.G.E.
	dodoc AUTHORS README
	prepgamesdirs
}
