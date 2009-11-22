# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnubg/gnubg-20090817.ebuild,v 1.3 2009/11/22 23:55:30 volkmar Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="GNU BackGammon"
HOMEPAGE="http://www.gnubg.org/"
SRC_URI="http://www.gnubg.org/media/sources/${PN}-source-SNAPSHOT-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="gtk opengl python threads"

RDEPEND="dev-libs/glib:2
	media-libs/libpng
	dev-libs/libxml2
	media-libs/freetype:2
	media-libs/libcanberra
	gtk? (
		x11-libs/gtk+:2
		x11-libs/cairo
		x11-libs/pango
		opengl? (
			x11-libs/gtkglext
			>=media-libs/ftgl-2.1.2-r1
		)
	)
	sys-libs/readline
	python? ( dev-lang/python )
	media-fonts/ttf-bitstream-vera
	virtual/libintl
	dev-db/sqlite:3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--localedir=/usr/share/locale \
		--docdir=/usr/share/doc/${PF}/html \
		$(use_enable threads) \
		$(use_with python) \
		$(use gtk || use opengl && echo --with-gtk) \
		$(use_with opengl board3d)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins ${PN}.weights *bd || die "doins failed"
	dodoc AUTHORS README NEWS
	dosym /usr/share/fonts/ttf-bitstream-vera "${GAMES_DATADIR}"/${PN}/fonts
	newicon textures/logo.png gnubg.png
	make_desktop_entry "gnubg -w" "GNU Backgammon"
	prepgamesdirs
}
