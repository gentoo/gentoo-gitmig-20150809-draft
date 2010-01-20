# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/showeq/showeq-5.13.9.1.ebuild,v 1.1 2010/01/20 11:33:32 tupone Exp $

EAPI=2
inherit eutils qt3 games

DESCRIPTION="An Everquest monitoring program"
HOMEPAGE="http://www.showeq.net/"
SRC_URI="mirror://sourceforge/seq/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/libpcap
	x11-libs/qt:3"
DEPEND="${RDEPEND}"

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-debug \
		--disable-optimization
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	doman showeq.1
	dodoc AUTHORS BUGS ChangeLog FAQ NEWS README ROADMAP TODO doc/*.{doc,txt}
	dohtml doc/map.html
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "For complete functionality, download and extract the following"
	elog "files into ${GAMES_DATADIR}/${PN}"
	elog
	elog "http://patch.everquest.com:7000/patch/everquest/main/eqstr_us.txt.gz"
	elog "http://patch.everquest.com:7000/patch/everquest/main/spells_us.txt.gz"
	elog
	elog "or simply run the following commands..."
	elog "  cd ${GAMES_DATADIR}/${PN}"
	elog "  for i in eqstr_us.txt spells_us.txt; do"
	elog "    wget --user-agent=SOEPatcher/curl \\"
	elog "      http://patch.everquest.com:7000/patch/everquest/main/\${i}.gz"
	elog "    gunzip \${i}.gz"
	elog "  done"
	echo
}
