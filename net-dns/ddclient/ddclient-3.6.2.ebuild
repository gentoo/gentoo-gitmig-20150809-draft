# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dns/ddclient/ddclient-3.6.2.ebuild,v 1.1 2002/06/29 00:55:03 bangert Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A perl based client for dyndns"
SRC_URI="http://burry.ca:4141/ddclient/${P}.tar.gz"
HOMEPAGE="http://burry.ca:4141/ddclient/"
RDEPEND="sys-devel/perl"
SLOT="0"

src_unpack() {
	unpack ${P}.tar.gz
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}
src_install () {

	exeinto /usr/sbin
	doexe ddclient
	insinto /etc/ddclient
	doins sample-*
	dodoc README COPYING COPYRIGHT
	exeinto /etc/init.d
	newexe ${FILESDIR}/ddclient.rc6 ddclient
}

