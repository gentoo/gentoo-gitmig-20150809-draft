# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/wulfstat/wulfstat-0.4.8.ebuild,v 1.3 2004/07/01 21:49:49 eradicator Exp $

DESCRIPTION="Provides a simple interface to the xmlsysd daemon."
SRC_URI="http://www.phy.duke.edu/~rgb/Beowulf/wulfstat/${PN}.tgz"
HOMEPAGE="http://www.phy.duke.edu/~rgb/Beowulf/wulfstat.php"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/libc
		>=dev-libs/libxml2-2.5.6
		>=sys-libs/zlib-1.1.4-r1
		>=sys-libs/ncurses-5.3-r1"
RDEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	make || die "Make failed"
}

src_install() {
	dobin wulfstat
	doman wulfstat.1

	dodoc wulfhosts.example DESIGN README
}
