# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ldap/python-ldap-2.0.0_pre04.ebuild,v 1.2 2002/05/27 17:27:37 drobbins Exp $

VERSION="2.0.0pre04"
S=${WORKDIR}/${PN}-${VERSION}
DESCRIPTION="Various LDAP-related Python modules"
SRC_URI="mirror://sourceforge/python-ldap/python-ldap-${VERSION}.tar.gz"
HOMEPAGE="http://python-ldap.sourceforge.net/"

DEPEND=">=dev-lang/python-2.2
	>=net-nds/openldap-2.0.11"

src_compile() {

	mv setup.cfg setup.cfg.orig
	sed "s|/usr/local/openldap2/lib|/usr/lib|" setup.cfg.orig | \
		sed "s|/usr/local/openldap2/include|/usr/include|" > setup.cfg \
			|| die

	python setup.py build || die

}

src_install() {

	python setup.py install --prefix=${D}/usr || die

	dodoc README

}

