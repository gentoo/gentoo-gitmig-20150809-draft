# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/moinmoin/moinmoin-1.2.1.ebuild,v 1.1 2004/03/17 19:14:39 stuart Exp $

inherit webapp-apache

PN0="moin"
S=${WORKDIR}/${PN0}-${PV}

DESCRIPTION="Python WikiClone"
SRC_URI="http://download.sourceforge.net/${PN0}/${PN0}-${PV}.tar.gz"
HOMEPAGE="http://moin.sourceforge.net"
KEYWORDS="x86 sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=dev-lang/python-2.2"

webapp-detect || NO_WEBSERVER=1
HTTPD_USER="apache"
HTTPD_GROUP="apache"

pkg_setup() {
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_compile() {
	python setup.py build || die "python build failed"
}

src_install () {
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}
	dodir ${destdir}

	python setup.py install --root=${D} --prefix=/usr install || die "python install failed"

	cd ${D}/usr/share/moin
	cp -r data htdocs/* ${D}/${HTTPD_ROOT}/${PN}
	cp cgi-bin/* ${D}/${HTTPD_ROOT}/${PN}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}:${HTTPD_USER} ${PN}
	cd ${D}/${HTTPD_ROOT}/${PN}
	chmod  a+x moin.cgi
	sed -i -e "s/\/wiki/\/moinmoin/" moin_config.py
}

pkg_postinst() {
	einfo
	einfo "MoinMoin requires that cgi be turned on in ${HTTPD_ROOT}/${P}."
	einfo
}
