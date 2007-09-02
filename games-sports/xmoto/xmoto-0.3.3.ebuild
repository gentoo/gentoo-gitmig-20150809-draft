# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/xmoto/xmoto-0.3.3.ebuild,v 1.1 2007/09/02 18:53:51 genstef Exp $

inherit eutils games

LVL="svg2lvl-0.4.0"
DESCRIPTION="A challenging 2D motocross platform game"
HOMEPAGE="http://xmoto.tuxfamily.org"
SRC_URI="http://download.tuxfamily.org/${PN}/${PN}/${PV}/${P}-src.tar.gz
	editor? ( http://download.tuxfamily.org/xmoto/svg2lvl/${LVL/*-}/${LVL}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls editor"

RDEPEND="media-libs/jpeg
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	net-misc/curl
	dev-lang/lua
	dev-games/ode
	virtual/opengl
	virtual/glu
	nls? ( virtual/libintl )
	editor? ( >=media-gfx/inkscape-0.45 )"
DEPEND="${RDEPEND}
	>=dev-db/sqlite-3
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:$(localedir):/usr/share/locale:' po/Makefile.in.in \
		|| die "sed Makefile.in.in failed"
	use editor && rm -f "${WORKDIR}"/${LVL}/{bezmisc,inkex}.py
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--with-enable-zoom=1 \
		--with-localesdir=/usr/share/locale \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README TODO ChangeLog

	doicon extra/xmoto.xpm
	domenu extra/xmoto.desktop

	prepgamesdirs

	if use editor; then
	  insinto /usr/share/inkscape/extensions
	  doins "${WORKDIR}"/${LVL}/*.{inx,py,xml} || die "doins failed"
	fi
}

pkg_postinst() {
	games_pkg_postinst
	if use editor; then
	  elog "If you want to know how to create Xmoto levels"
	  elog "have a look at this Tutorial:"
	  elog "http://wiki.xmoto.free.fr/index.php?title=Inkscape-0.3.0#Tutorial"
	  elog "You can share your levels on the Xmoto homepage."
	fi
}
