# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_random/mod_random-2.0.ebuild,v 1.6 2004/11/01 21:07:59 corsair Exp $

inherit eutils

DESCRIPTION="An Apache2 DSO providing custom randomized responses"
HOMEPAGE="http://software.tangent.org/"

S=${WORKDIR}/${P}
SRC_URI="http://software.tangent.org/download/${P}.tar.gz"
DEPEND="=net-www/apache-2*"
LICENSE="Apache-1.1"
KEYWORDS="x86 ~ppc64"
IUSE=""
SLOT="0"

src_unpack() {
	unpack ${A} || die; cd ${S} || die
	epatch ${FILESDIR}/mod_random-register.patch
}

src_compile() {
	apxs2 -c ${PN}.c || die
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe .libs/${PN}.so
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/17_mod_random.conf
	dodoc ${FILESDIR}/17_mod_random.conf
	dodoc ChangeLog INSTALL LICENSE README VERSION
	dohtml *.html
}
