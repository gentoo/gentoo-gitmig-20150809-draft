# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_loopback/mod_loopback-1.04.ebuild,v 1.3 2005/01/09 10:25:57 hollow Exp $

DESCRIPTION="A web client debugging tool (DSO) for Apache2"
HOMEPAGE="http://www.snert.com/Software/mod_loopback/index.shtml"

S=${WORKDIR}/${PN}-1.4
SRC_URI="http://www.snert.com/Software/download/${PN}104.tgz"
DEPEND="=net-www/apache-1*"
LICENSE="BSD"
KEYWORDS="~x86"
IUSE=""
SLOT="0"

src_compile() {
	apxs -c mod_loopback.c || die
}

src_install() {
	exeinto /usr/lib/apache-extramodules
	doexe ${PN}.so
	insinto /etc/apache/conf/modules.d
	doins ${FILESDIR}/28_mod_loopback.conf
	dodoc ${FILESDIR}/28_mod_loopback.conf CHANGES.txt LICENSE.txt
}
