# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/ez-ipupdate/ez-ipupdate-3.0.11_beta8.ebuild,v 1.1 2003/06/29 20:52:18 aliz Exp $

MY_PV=${PV/_beta/b}

S="${WORKDIR}/${PN}-${MY_PV}"
SRC_URI="http://gusnet.cx/proj/ez-ipupdate/dist/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://gusnet.cx/proj/ez-ipupdate"
DESCRIPTION="Dynamic DNS client for lots of dynamic dns services"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="virtual/glibc"

src_compile() {
	cd ${S}
	./configure --host=${CHOST} --prefix=/usr || die	
	emake || die
}

src_install(){

	make DESTDIR=${D} install || die
	for f in example*.conf
	do
		mv ${f} ${f}_orig
		sed -e "s#/usr/local/bin/ez-ipupdate#/usr/bin/ez-ipupdate#g" \
			${f}_orig > ${f}
		dodoc ${f}
	done
	dodoc CHANGELOG COPYING INSTALL README
}
