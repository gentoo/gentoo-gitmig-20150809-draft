# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pcl/pcl-1.10.ebuild,v 1.1 2010/07/01 16:52:48 phajdan.jr Exp $

DESCRIPTION="A library to provide low-level coroutines for in-process context switching"
HOMEPAGE="http://www.xmailserver.org/libpcl.html"
SRC_URI="http://www.xmailserver.org/${P}.tar.gz"

# license not specified, but derived from GPL'd works
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

src_install() {
	dolib pcl/.libs/libpcl.a || die "dolib failed"
	dodoc ChangeLog INSTALL NEWS README || die "dodoc failed"
	dohtml man/pcl.html || die "dohtml failed"
	doman man/pcl.3 || die "doman failed"
	insinto /usr/include
	doins include/pcl.h || die "doins failed"
}
