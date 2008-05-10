# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/blobandconquer/blobandconquer-0.93.ebuild,v 1.1 2008/05/10 14:43:53 mr_bones_ Exp $

inherit eutils toolchain-funcs games

MY_PN=blobAndConquer
DESCRIPTION="Mission and objective based 3D action game"
HOMEPAGE="http://www.parallelrealities.co.uk/blobAndConquer.php"
SRC_URI="mirror://gentoo/${MY_PN}-${PV}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-ttf"

S=${WORKDIR}/${MY_PN}-${PV}

src_compile() {
	emake \
		CXX=$(tc-getCXX) \
		LIBPATH="${LDFLAGS}" \
		DATADIR="${GAMES_DATADIR}"/${PN}/ \
		DOCDIR=/usr/share/doc/${PF}/html/ \
		|| die "emake failed"
}

src_install() {
	dogamesbin ${MY_PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data gfx music sound textures || die "doins failed"
	doicon icons/${MY_PN}.png
	domenu icons/${MY_PN}.desktop
	cd doc
	dohtml -r images pages index.html
	dodoc README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "Until ${PN}-1.0, save games may be incompatible with previous"
	ewarn "versions."
}
