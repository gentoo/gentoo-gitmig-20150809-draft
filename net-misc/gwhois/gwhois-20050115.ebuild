# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gwhois/gwhois-20050115.ebuild,v 1.1 2005/01/16 00:46:43 wschlich Exp $

inherit eutils flag-o-matic

DESCRIPTION="generic whois"
HOMEPAGE="http://gwhois.de/"
SRC_URI="http://gwhois.de/gwhois/${P/-/_}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="net-www/lynx
	net-misc/curl
	dev-lang/perl
	dev-perl/libwww-perl"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_install() {
	dodir /etc/gwhois
	insinto /etc/gwhois
	doins pattern
	dobin gwhois
	doman gwhois.1
	dodoc TODO gwhois.xinetd
	einfo ""
	einfo "See included gwhois.xinetd for an example on how to"
	einfo "use gwhois as a whois proxy using xinetd."
	einfo "Just copy gwhois.xinetd to /etc/xinetd.d/gwhois"
	einfo "and reload xinetd."
	einfo ""
}
