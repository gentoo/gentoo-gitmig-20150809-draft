# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/wasabi/wasabi-0.1-r1.ebuild,v 1.1 2004/06/17 23:02:21 g2boojum Exp $

DESCRIPTION="Log parsing and notification program"
HOMEPAGE="http://www.gentoo.org/~lcars/wasabi"
SRC_URI="http://www.gentoo.org/~lcars/wasabi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-perl/Storable
	     dev-perl/BerkeleyDB
		 dev-perl/File-Tail"

src_install() {
	doman wasabi.8
	dodoc CREDITS Changelog README
	dosbin wasabi
	exeinto /etc/init.d
	newexe ${FILESDIR}/wasabi.init wasabi
	dodir /etc/wasabi
	insinto /etc/wasabi ; doins wasabi.conf
}
