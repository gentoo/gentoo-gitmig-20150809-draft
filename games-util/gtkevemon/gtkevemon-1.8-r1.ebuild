# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/gtkevemon/gtkevemon-1.8-r1.ebuild,v 1.1 2011/07/21 15:03:58 wired Exp $

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
	dev-util/pkgconfig
"

src_prepare() {
	sed -e 's:Categories=Game;$:Categories=Game;RolePlaying;GTK;:' \
		-i icon/${PN}.desktop || die "sed failed"

	# upstream fix for new character portrait URL
	epatch "${FILESDIR}/${P}-portrait.patch"
	# upstream fix for remap calculation after learning skills removal
	epatch "${FILESDIR}/${P}-learning.patch.gz"
}

src_install() {
	dobin src/${PN}
	doicon icon/${PN}.xpm
	domenu icon/${PN}.desktop
	dodoc CHANGES README TODO
}
