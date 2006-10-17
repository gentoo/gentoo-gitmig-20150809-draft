# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-kde-games/ggz-kde-games-0.0.13.ebuild,v 1.1 2006/10/17 01:00:02 nyhm Exp $

inherit kde-functions games

DESCRIPTION="The KDE versions of the games for GGZ Gaming Zone"
HOMEPAGE="http://www.ggzgamingzone.org/"
SRC_URI="http://ftp.ggzgamingzone.org/pub/ggz/${PV}/${P}.tar.gz
	http://mirrors.ibiblio.org/pub/mirrors/ggzgamingzone/ggz/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RESTRICT="userpriv"

DEPEND="~games-board/ggz-kde-client-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:@prefix@:/usr:' \
		$(find . -name module.dsc.in) \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--datadir=/usr/share \
		|| die
	emake || die "emake failed"
}

src_install() {
	if [[ -f "${ROOT}/${GAMES_SYSCONFDIR}"/ggz/ggz.modules ]] ; then
		dodir "${GAMES_SYSCONFDIR}"/ggz
		cp {"${ROOT}","${D}"}/"${GAMES_SYSCONFDIR}"/ggz/ggz.modules
	fi
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS *.GGZ README TODO
	prepgamesdirs
}
