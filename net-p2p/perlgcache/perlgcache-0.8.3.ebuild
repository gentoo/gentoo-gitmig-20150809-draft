# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/perlgcache/perlgcache-0.8.3.ebuild,v 1.3 2004/11/23 21:03:41 squinky86 Exp $

inherit webapp

DESCRIPTION="web-based distributed host caching system for the gnutella network"
HOMEPAGE="http://www.jonatkins.com/perlgcache/"
SRC_URI="http://www.jonatkins.com/perlgcache/${P}.tar.gz"
LICENSE="as-is"
IUSE=""
KEYWORDS="x86 ~ppc"

DEPEND=">=sys-apps/sed-4"
RDEPEND=">=net-www/apache-1.3.24-r1
	>=dev-lang/perl-5.6.0
	>=dev-perl/CGI-2.93"

S=${WORKDIR}

pkg_preinst() {
	webapp_src_preinst
	ewarn "Only install this package if you know what you're doing!"
	ewarn "YOU HAVE BEEN WARNED: while using this package benefits the"
	ewarn "gnutella network, it will cause many gnutella users to"
	ewarn "connect to your web server, requiring many system resources."
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:\#\$config{prefix} = \"data\":\$config{prefix} = \"data/data\":g' perlgcache.conf
}

src_install() {
	webapp_src_preinst
	dodir ${MY_CGIBINDIR}/${PN}
	dodir ${MY_CGIBINDIR}/${PN}/data
	cp ./perlgcache.cgi ${D}/${MY_CGIBINDIR}/${PN}
	cp ./perlgcache.conf ${D}/${MY_CGIBINDIR}/${PN}
	chmod +x ${D}/${MY_CGIBINDIR}/${PN}/perlgcache.cgi
	keepdir ${D}/${MY_CGIBINDIR}/${PN}/data
	webapp_hook_script ${FILESDIR}/reconfig
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
