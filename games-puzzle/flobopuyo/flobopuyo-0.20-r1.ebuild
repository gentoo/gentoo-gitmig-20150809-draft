# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/flobopuyo/flobopuyo-0.20-r1.ebuild,v 1.1 2006/04/20 05:27:19 flameeyes Exp $

inherit toolchain-funcs eutils games

DESCRIPTION="Clone of the famous PuyoPuyo game"
HOMEPAGE="http://www.ios-software.com/?page=projet&quoi=29"
SRC_URI="http://www.ios-software.com/flobopuyo/${P}.tgz
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="opengl"

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	opengl? ( virtual/opengl )"

pkg_setup() {
	games_pkg_setup

	if ! built_with_use media-libs/sdl-image jpeg png ; then
		eerror "You need jpeg and png useflags enabled on media-libs/sdl-image."
		eerror "Please emerge media-libs/sdl-image with USE=\"jpeg png\""
		die "Missing jpeg or png useflags."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch \
		"${FILESDIR}"/${P}-gcc4.patch \
		"${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-libs.patch

	find . -type f -name ".*" -exec rm -f \{\} \;
	sed -i \
		-e "/strip/d" \
		-e "s:^DATADIR=.*:DATADIR=\"${GAMES_DATADIR}/${PN}\":" \
		-e "/^INSTALL_BINDIR/s:/\$(PREFIX)/games:${GAMES_BINDIR}:" \
		-e "s:^CFLAGS=:CFLAGS+=:" \
		-e "/^LDFLAGS=/d" \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	use opengl && want_opengl=true || want_opengl=false
	emake CC="$(tc-getCXX)" CXX="$(tc-getCXX)" \
		ENABLE_OPENGL="${want_opengl}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc Changelog TODO
	doman man/flobopuyo.6
	prepgamesdirs

	insinto /usr/share/icons/hicolor/128x128/apps
	doins "${DISTDIR}/${PN}.png"

	make_desktop_entry flobopuyo FloboPuyo flobopuyo "Game;ArcadeGame;"
	echo "TryExec=flobopuyo" >> ${D}/usr/share/applications/${PN}-flobopuyo.desktop
}
