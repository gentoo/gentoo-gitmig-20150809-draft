# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mping/mping-2.0_rc1.ebuild,v 1.2 2004/03/21 18:24:53 weeve Exp $

DESCRIPTION="IPv4/6 round-robin multiping client"
HOMEPAGE="http://mping.uninett.no"
SRC_URI="http://mping.uninett.no/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
