# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ldap/python-ldap-2.0.0_pre05-r1.ebuild,v 1.14 2005/01/03 15:53:48 gustavoz Exp $

VERSION="2.0.0pre05"
S=${WORKDIR}/${PN}-${VERSION}
DESCRIPTION="Various LDAP-related Python modules"
SRC_URI="mirror://sourceforge/python-ldap/python-ldap-${VERSION}.tar.gz"
HOMEPAGE="http://python-ldap.sourceforge.net/"

DEPEND="virtual/python
	>=net-nds/openldap-2.0.11"
SLOT="0"
LICENSE="PYTHON"
KEYWORDS="x86 sparc alpha"
IUSE=""

inherit distutils

src_compile() {
	mv setup.cfg setup.cfg.orig
	sed -e "s|/usr/local/openldap2/lib|/usr/lib|" \
	    -e "s|/usr/local/openldap2/include|/usr/include|" \
		-e "s|libs = ldap lber|libs = ldap lber resolv|" \
		setup.cfg.orig > setup.cfg || die

	distutils_src_compile
}
