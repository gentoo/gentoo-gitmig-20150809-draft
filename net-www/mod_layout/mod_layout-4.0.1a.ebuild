# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_layout/mod_layout-4.0.1a.ebuild,v 1.4 2004/04/04 22:53:31 zul Exp $

inherit eutils

DESCRIPTION="An Apache2 DSO module for adding custom headers and/or footers"
HOMEPAGE="http://software.tangent.org/"

S=${WORKDIR}/${P}
SRC_URI="http://software.tangent.org/download/${P}.tar.gz"
DEPEND="=net-www/apache-2*"
LICENSE="Apache-1.1"
KEYWORDS="x86"
IUSE=""
SLOT="0"

src_unpack() {
	unpack ${A} || die; cd ${S} || die
	epatch ${FILESDIR}/mod_layout-4.0.1a-register.patch
}

src_compile() {
	apxs2 -c mod_layout.c utility.c layout.c || die
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe .libs/${PN}.so
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/15_mod_layout.conf
	dodoc ${FILESDIR}/15_mod_layout.conf
	#thats all the docs there is right now!
}
