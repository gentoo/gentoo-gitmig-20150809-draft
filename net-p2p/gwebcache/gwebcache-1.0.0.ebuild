# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gwebcache/gwebcache-1.0.0.ebuild,v 1.3 2004/10/18 17:18:34 squinky86 Exp $

inherit webapp

DESCRIPTION="web-based distributed host caching system for the gnutella network"
HOMEPAGE="http://www.gnucleus.com/gwebcache/"
SRC_URI="http://www.gnucleus.com/gwebcache/dist/${P}.zip"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="x86 ~ppc"

DEPEND=">=app-arch/unzip-5.42-r1"
RDEPEND=">=net-www/apache-1.3.24-r1
	>=dev-lang/perl-5.6.0
	>=dev-perl/CGI-2.93"

pkg_preinst() {
	webapp_src_preinst
	ewarn "Only install this package if you know what you're doing!"
	ewarn "YOU HAVE BEEN WARNED: while using this package benefits the"
	ewarn "gnutella network, it will cause many gnutella users to"
	ewarn "connect to your web server, requiring many system resources."
}

src_install() {
	webapp_src_preinst
	dodoc license.txt
	dodir ${MY_CGIBINDIR}/${PN}
	cp ./g* ${D}/${MY_CGIBINDIR}/${PN}
	chmod +x ${D}/${MY_CGIBINDIR}/${PN}/gcache.cgi
	chmod 666 ${D}/${MY_CGIBINDIR}/${PN}/gdata.dat* ${D}/${MY_CGIBINDIR}/${PN}/gstatlog.txt
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
