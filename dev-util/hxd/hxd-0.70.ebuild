# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/hxd/hxd-0.70.ebuild,v 1.5 2004/07/02 05:08:53 eradicator Exp $

DESCRIPTION="Binary to hexadecimal converter"
HOMEPAGE="http://www-tet.ee.tu-berlin.de/solyga/linux/"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/utils/file/hex/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~mips"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dobin hxd unhxd
	doman hxd.1 unhxd.1
	dodoc CHANGELOG COPYING README TODO
}
