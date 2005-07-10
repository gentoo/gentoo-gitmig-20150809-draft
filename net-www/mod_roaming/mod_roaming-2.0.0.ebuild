# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_roaming/mod_roaming-2.0.0.ebuild,v 1.7 2005/07/10 00:53:51 swegener Exp $

inherit eutils

DESCRIPTION="Apache2 DSO enabling Netscape Communicator roaming profiles"
HOMEPAGE="http://www.klomp.org/mod_roaming/"

SRC_URI="http://www.klomp.org/${PN}/${P}.tar.gz"
DEPEND="=net-www/apache-2*"
LICENSE="BSD"
KEYWORDS="x86"
IUSE=""
SLOT="0"

src_unpack() {
	unpack ${A} || die; cd ${S} || die
	epatch ${FILESDIR}/mod_roaming-register.patch
}

src_compile() {
	apxs2 -c ${PN}.c || die
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe .libs/${PN}.so
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/18_mod_roaming.conf
	dodoc ${FILESDIR}/18_mod_roaming.conf
	dodoc CHANGES INSTALL LICENSE README
}

pkg_postinst() {
	#empty
	install -d -m 0755 -o apache -g apache ${ROOT}/var/lib/mod_roaming
}
