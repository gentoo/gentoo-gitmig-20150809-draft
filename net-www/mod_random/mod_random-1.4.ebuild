# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_random/mod_random-1.4.ebuild,v 1.2 2005/01/07 19:33:21 vericgar Exp $

inherit eutils

DESCRIPTION="An Apache DSO providing custom randomized responses"
HOMEPAGE="http://software.tangent.org/"

S=${WORKDIR}/${P}
SRC_URI="http://software.tangent.org/download/${P}.tar.gz"
DEPEND="=net-www/apache-1*"
LICENSE="Apache-1.1"
KEYWORDS="~x86"
IUSE=""
SLOT="0"


src_compile() {
	apxs -c ${PN}.c || die
}

src_install() {
	exeinto /usr/lib/apache-extramodules
	doexe .libs/${PN}.so
	insinto /etc/apache/conf/modules.d
	doins ${FILESDIR}/17_mod_random.conf
	dodoc ${FILESDIR}/17_mod_random.conf
	dodoc ChangeLog INSTALL LICENSE README VERSION
	dohtml *.html
}
