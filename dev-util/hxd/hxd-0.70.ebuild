# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/hxd/hxd-0.70.ebuild,v 1.1 2003/09/08 17:29:03 avenj Exp $

DESCRIPTION="Binary to hexadecimal converter"
HOMEPAGE="http://www-tet.ee.tu-berlin.de/solyga/linux/"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/utils/file/hex/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dobin hxd unhxd
	doman hxd.1 unhxd.1
	dodoc CHANGELOG COPYING README TODO
}
