# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/pandodl/pandodl-0.9.1.0.ebuild,v 1.1 2007/06/27 22:25:21 coldwind Exp $

inherit eutils

DESCRIPTION="Downloader client for the Pando torrent-like P2P system"
HOMEPAGE="http://www.pando.com/"
SRC_URI="http://www.pando.com/dl/download/${P}.tar.bz2"

LICENSE="Pando-EULA"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="strip"

DEPEND=""
RDEPEND="sys-libs/libstdc++-v3
	>=x11-libs/gtk+-2.6
	>=dev-libs/expat-2.0.0"

S=${WORKDIR}/${PN}

pkg_setup() {
	check_license
}

src_install() {
	insinto /opt/${PN}
	doins -r lib *.png

	exeinto /opt/${PN}/bin
	doexe bin/pandoDownloader

	dobin ${FILESDIR}/${PN}

	dodoc README
}
