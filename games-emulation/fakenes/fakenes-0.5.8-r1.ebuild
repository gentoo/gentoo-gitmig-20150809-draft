# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fakenes/fakenes-0.5.8-r1.ebuild,v 1.3 2010/07/17 07:02:03 ssuominen Exp $
EAPI=2

inherit eutils flag-o-matic toolchain-funcs games

DESCRIPTION="portable, Open Source NES emulator which is written mostly in C"
HOMEPAGE="http://fakenes.sourceforge.net/"
SRC_URI="mirror://sourceforge/fakenes/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="openal opengl zlib"

RDEPEND=">=media-libs/allegro-4.4.1.1[opengl?]
	dev-games/hawknl
	openal? (
		media-libs/openal
		media-libs/freealut )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i \
		-e "s:openal-config:pkg-config openal:" \
		build/openal.cbd || die

	sed -i \
		-e "s:LIBAGL = agl:LIBAGL = alleggl:" \
		build/alleggl.cbd || die
}

src_compile() {
	local myconf

	append-ldflags -Wl,-z,noexecstack

	$(tc-getCC) ${CFLAGS} cbuild.c -o cbuild || die "cbuild build failed"

	use openal || myconf="$myconf -openal"
	use opengl || myconf="$myconf -alleggl"
	use zlib   || myconf="$myconf -zlib"

	./cbuild ${myconf} || die "cbuild failed"
}

src_install() {
	dogamesbin fakenes || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins support/* || die "doins failed"
	dodoc docs/{CHANGES,README}
	dohtml docs/faq.html
	prepgamesdirs
}
