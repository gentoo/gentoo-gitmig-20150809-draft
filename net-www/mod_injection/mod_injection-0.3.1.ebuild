# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_injection/mod_injection-0.3.1.ebuild,v 1.5 2004/09/03 23:24:08 pvdabeel Exp $

inherit eutils

DESCRIPTION="An Apache2 filtering module"
HOMEPAGE="http://pmade.org/pjones/software/mod_injection/"

S=${WORKDIR}/${P}
SRC_URI="http://pmade.org/pjones/software/${PN}/download/${P}.tar.gz"
DEPEND="=net-www/apache-2*"
LICENSE="Apache-1.1"
KEYWORDS="x86 ppc"
IUSE=""
SLOT="0"

src_unpack() {
	unpack ${A} || die; cd ${S} || die
	epatch ${FILESDIR}/mod_injection-0.3.0-register.patch
}

src_compile() {
	cp src/${PN}.c .
	apxs2 -c ${PN}.c || die
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe .libs/${PN}.so
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/23_mod_injection.conf
	dodoc ${FILESDIR}/23_mod_injection.conf
	dodoc README INSTALL docs/CREDITS docs/manual.txt
	cp -a docs/manual ${D}/usr/share/doc/${PF}
}
