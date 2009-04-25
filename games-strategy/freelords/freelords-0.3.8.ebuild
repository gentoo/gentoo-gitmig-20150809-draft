# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freelords/freelords-0.3.8.ebuild,v 1.7 2009/04/25 23:59:18 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Free Warlords clone"
HOMEPAGE="http://freelords.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="editor nls"

RDEPEND="dev-libs/expat
	media-libs/sdl-mixer[vorbis]
	media-libs/libsdl
	media-libs/sdl-image
	>=media-libs/freetype-2
	>=media-libs/paragui-1.1.8
	dev-libs/libsigc++:1.2
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

src_prepare() {
	sed -i \
		-e '/locale/s:$(datadir):/usr/share:' \
		-e '/locale/s:$(prefix):/usr:' \
		-e 's:$(localedir):/usr/share/locale:' \
		-e '/freelords.desktop/d' \
		$(find -name 'Makefile.in*') \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-paraguitest \
		$(use_enable editor) \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}"/usr/share/locale/locale.alias
	doicon dat/various/${PN}.png
	make_desktop_entry ${PN} FreeLords
	if use editor ; then
		doicon dat/various/${PN}_editor.png
		make_desktop_entry ${PN}_editor "FreeLords Editor" ${PN}_editor
	fi
	dodoc AUTHORS ChangeLog HACKER NEWS README TODO doc/*.pdf
	prepgamesdirs
}
