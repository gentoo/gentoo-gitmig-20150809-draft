# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/ddclient/ddclient-3.6.2.ebuild,v 1.16 2004/10/20 18:42:18 vapier Exp $

inherit eutils

DESCRIPTION="A perl based client for dyndns"
HOMEPAGE="http://burry.ca:4141/ddclient/"
SRC_URI="http://burry.ca:4141/ddclient/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ppc sparc x86"
IUSE=""

RDEPEND="dev-lang/perl"

src_unpack() {
	unpack ${P}.tar.gz
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_install() {
	dosbin ddclient || die "dosbin"
	insinto /etc/ddclient
	doins sample-*
	dodoc README
	exeinto /etc/init.d
	newexe ${FILESDIR}/ddclient.rc6 ddclient
}
