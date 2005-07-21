# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/esekeyd/esekeyd-1.2.1.ebuild,v 1.5 2005/07/21 17:17:53 dholm Exp $

DESCRIPTION="Multimedia key daemon that uses the Linux event interface"
HOMEPAGE="http://www.majdom.com/~einstein/#esekeydaemon"
LICENSE="GPL-2"

SRC_URI="http://www.majdom.com/~einstein/files/${P}.tar.gz"

SLOT="0"
KEYWORDS="amd64 ~ppc"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die

	dodoc ChangeLog AUTHORS README TODO examples/example.conf NEWS
}
