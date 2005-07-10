# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_layout/mod_layout-3.2.1.ebuild,v 1.6 2005/07/10 00:56:41 swegener Exp $


DESCRIPTION="An Apache DSO module for adding custom headers and/or footers"
HOMEPAGE="http://software.tangent.org/"
SRC_URI="http://software.tangent.org/download/${P}.tar.gz"
DEPEND="=net-www/apache-1*"
RDEPEND=""

LICENSE="Apache-1.1"
KEYWORDS="x86"
IUSE=""
SLOT="0"

src_compile() {
	sed -i -e 's/-DDEBUG//g' Makefile || die "Makefile fixing Failed"
	emake || die "Module building failed."
}

src_install() {
	exeinto /usr/lib/apache-extramodules
	doexe ${PN}.so || die "Module installation failed."
	insinto /etc/apache/conf/addon-modules
	doins ${FILESDIR}/15_mod_layout321.conf
	dodoc ChangeLog INSTALL LICENSE README THANKS TODO VERSION
	dohtml faq.html directives/*
}

pkg_postinst() {
	einfo
	einfo "Execute \"ebuild /var/db/pkg/net-www/${PF}/${PF}.ebuild config\""
	einfo "to have your apache.conf auto-updated for use with this module."
	einfo "You should then edit your /etc/conf.d/apache file to suit."
	einfo
}

pkg_config() {
	${ROOT}/usr/sbin/apacheaddmod \
		${ROOT}/etc/apache/conf/apache.conf \
		extramodules/mod_layout.so mod_layout.c layout_module \
		define=LAYOUT addconf=conf/addon-modules/15_mod_layout321.conf
}
