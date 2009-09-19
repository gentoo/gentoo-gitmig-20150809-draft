# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/ggencoder/ggencoder-0.91a.ebuild,v 1.2 2009/09/19 12:37:14 maekke Exp $

EAPI=2
inherit eutils qt4

DESCRIPTION="Utility to encode and decode Game Genie (tm) codes."
HOMEPAGE="http://games.technoplaza.net/ggencoder/qt/"
SRC_URI="http://games.technoplaza.net/ggencoder/qt/history/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4"

S=${WORKDIR}/${P}/source

src_configure() {
	eqmake4
}

src_install() {
	dobin ${PN} || die "dobin failed"
	dodoc ../docs/ggencoder.txt || die "dodoc failed"
	if use doc ; then
		dohtml -r ../apidocs/html/* || die "dohtml failed"
	fi
}
