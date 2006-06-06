# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/rrootage/rrootage-0.23a.ebuild,v 1.7 2006/06/06 15:44:48 blubb Exp $

inherit eutils games

MY_PN="rRootage"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Abstract shooter - defeat auto-created huge battleships"
HOMEPAGE="http://www.asahi-net.or.jp/~cs8k-cyu/windows/rr_e.html
	http://rrootage.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-mixer
	>=dev-libs/libbulletml-0.0.3"

S="${WORKDIR}/${MY_PN}/src"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gcc41.patch
	sed -e "s/-lglut/-lGL -lGLU/" makefile.lin > Makefile || die "sed failed"

	sed -i \
		-e "s:/usr/share/games:${GAMES_DATADIR}:" \
		barragemanager.cc screen.c soundmanager.c \
		|| die "sed failed"
}

src_compile() {
	emake MORE_CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	newgamesbin rr ${PN} || die "newgamesbin failed"
	dodir "${GAMES_DATADIR}/${MY_PN}"
	cp -r ../rr_share/* "${D}/${GAMES_DATADIR}/${MY_PN}" || die "cp failed"
	dodoc ../readme*
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if ! built_with_use media-libs/sdl-mixer vorbis ; then
		einfo "${PN} will not have sound since sdl-mixer"
		einfo "is built with USE=-vorbis"
		einfo "Please emerge sdl-mixer with USE=vorbis"
		einfo "if you want sound support"
	fi
}
