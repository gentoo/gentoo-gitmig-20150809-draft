# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/rufus/rufus-0.7.0.ebuild,v 1.3 2006/04/20 03:55:16 tester Exp $

inherit distutils

MY_PN=${PN/r/R}

DESCRIPTION="A bittorrent client based off g3torrent"
HOMEPAGE="http://rufus.sourceforge.net/"
SRC_URI="http://www.tsunam.org/files/overlay/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="${RDEPEND}
	app-arch/unzip"
RDEPEND=">=dev-lang/python-2.4.0
	>=dev-python/wxpython-2.6.1.0
	=dev-python/pyopenssl-0.6
	dev-libs/openssl"

PROVIDE="virtual/bittorrent"

PIXMAPLOC="/usr/share/rufus"
S="${WORKDIR}/${P/-/_}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_install() {
	distutils_src_install
	dodir ${PIXMAPLOC}
	insinto ${PIXMAPLOC}
	doins rufus.py

	dodir ${PIXMAPLOC}/images
	insinto ${PIXMAPLOC}/images
	doins images/*.png images/*.bmp

	insinto /usr/share/pixmaps
	doins images/rufus.png

	dodir ${PIXMAPLOC}/images/flags
	insinto ${PIXMAPLOC}/images/flags
	doins images/flags/*

	dobin rufus

	dodoc TODO.TXT CHANGELOG.TXT

}
