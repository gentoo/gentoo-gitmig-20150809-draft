# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/ez-ipupdate/ez-ipupdate-3.0.11_beta7.ebuild,v 1.8 2003/02/13 13:57:51 vapier Exp $

S="${WORKDIR}/${PN}-3.0.11b7"
SRC_URI="http://gusnet.cx/proj/ez-ipupdate/dist/${PN}-3.0.11b7.tar.gz"
HOMEPAGE="http://gusnet.cx/proj/ez-ipupdate"
DESCRIPTION="Dynamic DNS client for lots of dynamic dns services"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

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
