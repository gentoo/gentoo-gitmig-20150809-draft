# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/noiz2sa/noiz2sa-0.51a.ebuild,v 1.6 2006/04/21 18:29:40 tupone Exp $

inherit eutils games

DESCRIPTION="Abstract Shooting Game"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.asahi-net.or.jp/~cs8k-cyu/windows/noiz2sa_e.html http://sourceforge.net/projects/noiz2sa/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="media-libs/sdl-mixer
	>=dev-libs/libbulletml-0.0.3
	virtual/opengl"

S="${WORKDIR}/${PN}"

src_unpack(){
	unpack ${A}
	cd "${S}/src"
	epatch "${FILESDIR}/${P}"-gcc41.patch
	sed -e "s/-lglut/-lGL/" makefile.lin > Makefile || die "sed failed"

	sed -i \
		-e "s:/.noiz2sa.prf:/noiz2sa.prf:" \
		-e "s:getenv(\"HOME\"):\"${GAMES_STATEDIR}\":" \
		attractmanager.c \
		|| die "sed failed"
}

src_compile(){
	emake -C src MORE_CFLAGS="${CFLAGS}" || die
}

src_install(){
	local datadir="${GAMES_DATADIR}/${PN}"

	dogamesbin src/${PN} || die "dogamesbin failed"
	dodir "${datadir}" "${GAMES_STATEDIR}"
	cp -r noiz2sa_share/* "${D}/${datadir}" || die "cp failed"
	dodoc readme*
	touch "${D}${GAMES_STATEDIR}/${PN}.prf"
	fperms 660 "${GAMES_STATEDIR}/${PN}.prf"
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
