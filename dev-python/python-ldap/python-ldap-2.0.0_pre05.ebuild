# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ldap/python-ldap-2.0.0_pre05.ebuild,v 1.2 2002/08/16 02:49:58 murphy Exp $

VERSION="2.0.0pre05"
S=${WORKDIR}/${PN}-${VERSION}
DESCRIPTION="Various LDAP-related Python modules"
SRC_URI="mirror://sourceforge/python-ldap/python-ldap-${VERSION}.tar.gz"
HOMEPAGE="http://python-ldap.sourceforge.net/"

DEPEND="virtual/python
	>=net-nds/openldap-2.0.11"
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="public-domain" # NOTE: win32 section is under questionable license
KEYWORDS="x86 sparc sparc64"

src_compile() {

	mv setup.cfg setup.cfg.orig
	sed -e "s|/usr/local/openldap2/lib|/usr/lib|" \
	    -e "s|/usr/local/openldap2/include|/usr/include|" > setup.cfg \
			|| die

	base_src_compile 
}

inherit distutils
