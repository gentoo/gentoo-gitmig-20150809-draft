# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/neverball/neverball-1.5.0.ebuild,v 1.6 2009/04/14 09:50:06 armin76 Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Clone of Super Monkey Ball using SDL/OpenGL"
HOMEPAGE="http://icculus.org/neverball/"
SRC_URI="http://icculus.org/neverball/${P}.tar.gz"

LICENSE="GPL-2 BitstreamVera"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"
RESTRICT="test"

RDEPEND="media-libs/libsdl[joystick]
	media-libs/sdl-ttf
	media-libs/libpng
	media-libs/jpeg
	media-libs/libvorbis
	virtual/opengl
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_prepare() {
	sed -i \
		-e '/CONFIG_DATA/s:"\./data":"'${GAMES_DATADIR}/${PN}'":g' \
		-e '/CONFIG_LOCALE/s:"\./data":"/usr/share/locale":g' \
		share/base_config.h \
		|| die "sed failed"
	sed -i \
		-e 's:mapc:neverball-mapc:g' \
		-e 's:MAPC:NEVERBALL-MAPC:g' \
		-e '1 s/ 1 / 6 /' \
		dist/mapc.1 \
		|| die "sed failed"
	sed -i \
		-e 's:-O2:$(E_CFLAGS):' \
		-e "/^MAPC_TARG/s/mapc/${PN}-mapc/" \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	LINGUAS= \
	emake \
		ENABLE_NLS=$(use nls && echo 1 || echo 0) \
		E_CFLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dogamesbin ${PN}-mapc neverball neverputt || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data/* || die "doins failed"
	if use nls ; then
		insinto /usr/share
		doins -r locale || die "doins failed"
	fi
	dodoc CHANGES README

	newicon dist/neverball_512.png neverball.png
	newicon dist/neverputt_512.png neverputt.png
	doman dist/*.6
	newman dist/mapc.1 neverball-mapc.6
	make_desktop_entry neverball Neverball
	make_desktop_entry neverputt Neverputt neverputt

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "${P} will overwrite existing high-score files, so back them up if you want to preserve your old scores and progress."
}
