# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/noiz2sa/noiz2sa-0.51a.ebuild,v 1.10 2010/09/15 18:48:44 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Abstract Shooting Game"
HOMEPAGE="http://www.asahi-net.or.jp/~cs8k-cyu/windows/noiz2sa_e.html http://sourceforge.net/projects/noiz2sa/"
SRC_URI="mirror://sourceforge/noiz2sa/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/sdl-mixer[vorbis]
	>=dev-libs/libbulletml-0.0.3
	virtual/opengl"

S=${WORKDIR}/${PN}

src_prepare(){
	cd "${S}/src"
	epatch "${FILESDIR}/${P}"-gcc41.patch
	sed \
		-e '/^CC/d' \
		-e '/^CXX/d' \
		-e '/^LDFLAGS/s/=/+=/' \
		-e "s/-lglut/-lGL/" \
		makefile.lin > Makefile \
		|| die "sed failed"

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
	if ! has_version "media-libs/sdl-mixer[vorbis]" ; then
		elog "${PN} will not have sound since sdl-mixer"
		elog "is built with USE=-vorbis"
		elog "Please emerge sdl-mixer with USE=vorbis"
		elog "if you want sound support"
	fi
}
