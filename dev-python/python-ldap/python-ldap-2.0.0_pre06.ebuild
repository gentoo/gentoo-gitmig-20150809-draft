# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ldap/python-ldap-2.0.0_pre06.ebuild,v 1.3 2003/06/21 22:30:25 drobbins Exp $

inherit distutils

IUSE=""
MYP=${P/_pre/pre}
S=${WORKDIR}/${MYP}
DESCRIPTION="Various LDAP-related Python modules"
SRC_URI="mirror://sourceforge/${PN}/${MYP}.tar.gz"
HOMEPAGE="http://python-ldap.sourceforge.net/"

DEPEND="virtual/python
	>=net-nds/openldap-2.0.11"
SLOT="0"
LICENSE="public-domain" # NOTE: win32 section is under questionable license
KEYWORDS="x86 amd64 ~sparc ~alpha"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s|/usr/local/openldap.*/lib|/usr/lib|" \
	    -e "s|/usr/local/openldap.*/include|/usr/include|" \
		-e "s|libs = ldap lber|libs = ldap lber resolv|" \
		-i setup.cfg || die "error fixing setup.cfg"

}
