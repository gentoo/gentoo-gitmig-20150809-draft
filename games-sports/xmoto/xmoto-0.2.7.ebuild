# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/xmoto/xmoto-0.2.7.ebuild,v 1.1 2007/03/20 21:24:48 genstef Exp $

inherit eutils games

LVL_N="svg2lvl"
LVL_V="0.3.0"

DESCRIPTION="A challenging 2D motocross platform game"
HOMEPAGE="http://xmoto.tuxfamily.org"
SRC_URI="http://download.tuxfamily.org/${PN}/${PN}/${PV}/${P}-src.tar.gz
	editor? ( mirror://sourceforge/${PN}/${LVL_N}-${LVL_V}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls editor"

RDEPEND="media-libs/jpeg
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-mixer
	net-misc/curl
	dev-lang/lua
	dev-games/ode
	virtual/opengl
	virtual/glu
	nls? ( virtual/libintl )
	editor? ( >=media-gfx/inkscape-0.45 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:$(localedir):/usr/share/locale:' po/Makefile.in.in \
		|| die "sed Makefile.in.in failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--with-localesdir=/usr/share/locale \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README TODO ChangeLog

	doicon extra/xmoto.xpm
	domenu extra/xmoto{,-edit}.desktop

	prepgamesdirs

	if use editor; then
	  insinto /usr/share/inkscape/extensions
	  doins ${WORKDIR}/${LVL_N}-${LVL_V}/*
	fi
}
