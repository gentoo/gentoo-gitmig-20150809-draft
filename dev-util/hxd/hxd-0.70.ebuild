# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/hxd/hxd-0.70.ebuild,v 1.9 2009/09/23 17:45:18 patrick Exp $

DESCRIPTION="Binary to hexadecimal converter"
HOMEPAGE="http://www-tet.ee.tu-berlin.de/solyga/linux/"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/utils/file/hex/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc ~mips ~ppc"
IUSE=""

DEPEND=""

src_install() {
	dobin hxd unhxd
	doman hxd.1 unhxd.1
	dodoc CHANGELOG README TODO
}
