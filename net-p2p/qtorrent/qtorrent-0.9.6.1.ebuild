# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qtorrent/qtorrent-0.9.6.1.ebuild,v 1.5 2004/07/18 17:00:58 weeve Exp $

DESCRIPTION="QTorrent is a PyQt GUI for BitTorrent."
HOMEPAGE="http://thegraveyard.org/qtorrent.php"
SRC_URI="http://thegraveyard.org/files/${P}.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc ~sparc"
IUSE=""
DEPEND="dev-python/PyQt"
#RDEPEND=""

src_install() {
	python setup.py install --prefix=${D}/usr
}
