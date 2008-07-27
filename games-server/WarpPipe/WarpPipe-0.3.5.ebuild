# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/WarpPipe/WarpPipe-0.3.5.ebuild,v 1.5 2008/07/27 21:23:43 carlo Exp $

EAPI=1

inherit qt3

DESCRIPTION="connect gamecubes together over the network"
HOMEPAGE="http://www.warppipe.com/"
SRC_URI="http://www.warppipe.com/download/${P}-linux.tar.gz"

LICENSE="WarpPipe"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND="x11-libs/qt:3"

S=${WORKDIR}/${P}-linux

src_install() {
	into /opt
	dobin WarpPipe || die
	newbin soshell WarpPipe-soshell || die
}
