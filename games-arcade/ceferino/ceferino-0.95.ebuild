# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ceferino/ceferino-0.95.ebuild,v 1.3 2005/06/15 18:06:21 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Super-Pang clone (destroy bouncing balloons with your grapnel)"
HOMEPAGE="http://www.loosersjuegos.com.ar/pagina.php?nombre=proyecto_don_ceferino..."
SRC_URI="http://www.loosersjuegos.com.ar/descargas/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="nls"

RDEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-image-1.2
	>=media-libs/sdl-mixer-1.2"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^install-data-am/s:install-docDATA::' Makefile.in \
		|| die "sed failed"
	sed -i \
		-e '/^\(gnu\)\?localedir /s:= .*:= /usr/share/locale:' \
		po/Makefile.in.in src/Makefile.in \
		|| die "sed failed"
}

src_compile() {
	egamesconf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README README_ES TODO
	newicon src/ima/icono.png ${PN}.png
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
