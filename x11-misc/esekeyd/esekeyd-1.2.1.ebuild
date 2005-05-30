# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/esekeyd/esekeyd-1.2.1.ebuild,v 1.1 2005/05/30 05:15:00 tester Exp $

DESCRIPTION="e"
HOMEPAGE="http://www.majdom.com/~einstein/#esekeydaemon"
LICENSE="GPL-2"

SRC_URI="http://www.majdom.com/~einstein/files/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	make DESTDIR=${D} install || die

	dodoc ChangeLog AUTHORS README TODO examples/example.conf NEWS
}
