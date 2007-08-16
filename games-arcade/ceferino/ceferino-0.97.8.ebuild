# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ceferino/ceferino-0.97.8.ebuild,v 1.1 2007/08/16 00:51:36 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Super-Pang clone (destroy bouncing balloons with your grapnel)"
HOMEPAGE="http://www.loosersjuegos.com.ar/juegos/ceferino/ceferino.php"
SRC_URI="http://www.loosersjuegos.com.ar/juegos/ceferino/descargas/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-image-1.2
	>=media-libs/sdl-mixer-1.2
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '/^\(gnu\)\?localedir /s:= .*:= /usr/share/locale:' \
		po/Makefile.in.in || die "sed failed"
	sed -i '/^INCLUDES/s:\$(datadir)/locale:/usr/share/locale:' \
		src/Makefile.in || die "sed failed"
}

src_compile() {
	egamesconf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
	newicon data/ima/icono.png ${PN}.png
	make_desktop_entry ceferino "Don Ceferino Hazaña"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if ! built_with_use media-libs/sdl-mixer mikmod ; then
		ewarn
		ewarn "To hear music, you will have to rebuild media-libs/sdl-mixer"
		ewarn "with the \"mikmod\" USE flag turned on."
		ewarn
	fi
}
