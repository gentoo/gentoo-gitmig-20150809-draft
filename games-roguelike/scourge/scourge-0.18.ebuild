# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/scourge/scourge-0.18.ebuild,v 1.3 2007/09/28 23:49:52 dirtyepic Exp $

inherit autotools eutils wxwidgets games

DESCRIPTION="A graphical rogue-like adventure game"
HOMEPAGE="http://scourge.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.src.tar.gz
	mirror://sourceforge/${PN}/${P}.data.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="editor"

RDEPEND="virtual/glu
	virtual/opengl
	>=media-libs/freetype-2
	media-libs/libsdl
	media-libs/sdl-net
	media-libs/sdl-mixer
	virtual/libintl
	editor? ( =x11-libs/wxGTK-2.6* )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

S=${WORKDIR}/${PN}

pkg_setup() {
	games_pkg_setup
	use editor && WX_GTK_VER="2.6" need-wxwidgets gtk2
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	if use editor ; then
		sed -i \
			-e "/WXWIDGET_CFLAGS/s:wx-config:${WX_CONFIG}:" \
			-e "/WXWIDGET_LIBS/s:wx-config:${WX_CONFIG}:" \
			configure.in || die "sed failed"
	fi
	epatch "${FILESDIR}"/${P}-gcc42.patch
	eautoreconf
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--with-data-dir="${GAMES_DATADIR}"/${PN} \
		--localedir=/usr/share/locale \
		$(use_enable editor) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	use editor && mv "${D}/${GAMES_BINDIR}"/{tools,${PN}-tools}
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r ../scourge_data/* || die "doins failed"
	doicon assets/scourge.png
	make_desktop_entry scourge S.C.O.U.R.G.E.
	dodoc AUTHORS README
	prepgamesdirs
}
