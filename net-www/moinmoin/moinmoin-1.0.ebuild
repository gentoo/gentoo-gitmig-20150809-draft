# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/moinmoin/moinmoin-1.0.ebuild,v 1.4 2002/08/16 03:01:02 murphy Exp $

PN0="moin"
S=${WORKDIR}/${PN0}-${PV}
HTTPD_ROOT="/home/httpd/htdocs"
HTTPD_USER="apache"

DESCRIPTION="Python WikiClone"

SRC_URI="http://download.sourceforge.net/${PN0}/${PN0}-${PV}.tar.gz"
HOMEPAGE="http://moin.sourceforge.net"
KEYWORDS="x86 sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=dev-lang/python-2.2"

RDEPEND="net-www/apache"

src_compile() {
	python setup.py build || die "python build failed"
}

src_install () {
	python setup.py install --root=${D} --prefix=/usr install || die "python install failed"
	dodir ${HTTPD_ROOT}/${P}
	dosym ${HTTPD_ROOT}/${P} ${HTTPD_ROOT}/${PN}
	cd ${D}/usr/share/moin
	cp -r data htdocs/* ${D}/${HTTPD_ROOT}/${P}
	cp cgi-bin/* ${D}/${HTTPD_ROOT}/${P}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}.${HTTPD_USER} ${P}
	cd ${D}/${HTTPD_ROOT}/${P}
	chmod  a+x moin.cgi
	mv moin_config.py moin_config.py.orig
	sed -e "s/\/wiki/\/moinmoin/" moin_config.py.orig \
		> moin_config.py
	rm moin_config.py.orig
}

pkg_postinst() {
	einfo
	einfo "MoinMoin requires that cgi be turned on in ${HTTPD_ROOT}/${P}."
	einfo
}
