# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/ez-ipupdate/ez-ipupdate-3.0.11_beta8.ebuild,v 1.3 2004/06/24 22:35:34 agriffis Exp $

MY_PV=${PV/_beta/b}
S="${WORKDIR}/${PN}-${MY_PV}"
DESCRIPTION="Dynamic DNS client for lots of dynamic dns services"
HOMEPAGE="http://gusnet.cx/proj/ez-ipupdate"
SRC_URI="http://gusnet.cx/proj/ez-ipupdate/dist/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install(){
	make DESTDIR=${D} install || die
	sed -i 's#/usr/local/bin/ez-ipupdate#/usr/bin/ez-ipupdate#g' *.conf
	dodoc *.conf CHANGELOG README
}
