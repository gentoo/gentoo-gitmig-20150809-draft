# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mod_python/mod_python-3.0.1.ebuild,v 1.4 2003/06/21 22:30:24 drobbins Exp $

DESCRIPTION="An Apache2 DSO providing an embedded Python interpreter"
HOMEPAGE="http://www.modpython.org/"

SRC_URI="http://www.apache.org/dist/httpd/modpython/${P}.tgz"
DEPEND="dev-lang/python >=net-www/apache-2.0"
LICENSE="Apache-1.1"
KEYWORDS="x86 amd64"
IUSE=""
SLOT="0"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	patch -p0 <${FILESDIR}/mod_python-3.0.0_beta4-destdir.diff || die
}

src_compile() {
	./configure --with-apxs=/usr/sbin/apxs2 || die
	make OPT="`apxs2 -q CFLAGS` -fPIC" || die
}

src_install() {
	dodir /usr/lib/{apache2,apache2-extramodules}
	make install DESTDIR=${D} || die
	mv ${D}/usr/lib/apache2/${PN}.so ${D}/usr/lib/apache2-extramodules
	rm -rf ${D}/usr/lib/apache2
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/16_mod_python.conf
	dodoc ${FILESDIR}/16_mod_python.conf README NEWS CREDITS COPYRIGHT
	dohtml doc-html/*
}
