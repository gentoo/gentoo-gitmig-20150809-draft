# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/greenhouse/greenhouse-1.0.1.ebuild,v 1.1 2008/04/13 07:26:38 jmglov Exp $

inherit eutils

DESCRIPTION="The Greenhouse is a game store brought together by Penny Arcade and Hothead Games."
HOMEPAGE="http://www.playgreenhouse.com/"
SRC_URI="http://download.playgreenhouse.com/downloaderlinux-${PV}.tar.gz"

LICENSE="Greenhouse"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

# Greenhouse is statically linked, so it has no external dependencies
# and should not be stripped
RESTRICT="strip"
DEPEND=""
RDEPEND=""

#S="${WORKDIR}/${P}"

src_compile() {
	einfo "Binary package; nothing to compile"
}

src_install() {
	mv DownloaderLin ${PN}
	dobin ${PN}
}
