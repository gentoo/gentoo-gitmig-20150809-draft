# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/midentd/midentd-2.3.1.ebuild,v 1.1 2004/03/05 15:47:07 vapier Exp $

DESCRIPTION="ident daemon with masquerading and fake replies support"
HOMEPAGE="http://panorama.sth.ac.at/midentd/"
SRC_URI="http://panorama.sth.ac.at/midentd/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:/usr/local:/usr:' midentd.xinetd
}

src_install() {
	dosbin midentd midentd.logcycle || die

	insinto /etc/xinetd.d
	doins midentd.xinetd
	exeinto /etc/init.d
	newexe ${FILESDIR}/midentd.rc midentd

	dodoc CHANGELOG README

	dodir /var/log
	touch ${D}/var/log/midentd.log
	fowners nobody:nobody /var/log/midentd.log
}
