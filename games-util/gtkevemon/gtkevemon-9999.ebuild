# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/gtkevemon/gtkevemon-9999.ebuild,v 1.2 2012/05/03 03:41:15 jdhore Exp $

EAPI=4

inherit eutils

IUSE=""
if [[ ${PV} == *9999* ]]; then
	inherit subversion
	ESVN_REPO_URI="svn://svn.battleclinic.com/GTKEVEMon/trunk/${PN}"
	KEYWORDS=""
	SRC_URI=""
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="http://gtkevemon.battleclinic.com/releases/${P}-source.tar.gz"
fi

DESCRIPTION="A standalone skill monitoring application for EVE Online"
HOMEPAGE="http://gtkevemon.battleclinic.com"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-cpp/gtkmm:2.4
	dev-libs/libxml2
"
DEPEND="${DEPEND}
	virtual/pkgconfig
"

src_prepare() {
	sed -e 's:Categories=Game;$:Categories=Game;RolePlaying;GTK;:' \
		-i icon/${PN}.desktop || die "sed failed"
}

src_install() {
	dobin src/${PN}
	doicon icon/${PN}.png
	domenu icon/${PN}.desktop
	dodoc CHANGES README TODO
}
