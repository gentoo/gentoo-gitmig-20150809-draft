# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qtorrent/qtorrent-0.9.6.1-r1.ebuild,v 1.3 2006/02/22 11:22:13 lucass Exp $

inherit eutils

DESCRIPTION="QTorrent is a PyQt GUI for BitTorrent."
HOMEPAGE="http://thegraveyard.org/qtorrent.php"
SRC_URI="http://thegraveyard.org/files/${P}.tar.bz2
	mirror://gentoo/${P}-sizetype.patch"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""
DEPEND="dev-python/PyQt"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/${P}-sizetype.patch
}

src_install() {
	python setup.py install --prefix=${D}/usr
}
