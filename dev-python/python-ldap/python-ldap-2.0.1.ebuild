# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ldap/python-ldap-2.0.1.ebuild,v 1.3 2004/11/03 14:36:49 sejo Exp $

inherit distutils

IUSE="sasl ssl"
#MY_P=${P/_pre/pre}
#S=${WORKDIR}/${MY_P}
DESCRIPTION="Various LDAP-related Python modules"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://python-ldap.sourceforge.net/"

DEPEND="virtual/python
	>=net-nds/openldap-2.0.11
	sasl? ( dev-libs/cyrus-sasl )"

SLOT="0"
LICENSE="PYTHON"
KEYWORDS="~x86 ~sparc ~alpha ppc"

PYTHON_MODNAME="ldap"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s|/usr/local/openldap.*/lib|/usr/lib|" \
	    -e "s|/usr/local/openldap.*/include|/usr/include|" \
		-i setup.cfg || die "error fixing setup.cfg"

	local mylibs
	use sasl \
		&& mylibs="${mylibs} sasl2 ldap" \
		|| mylibs="${mylibs} ldap"

	# Fixes bug #25693
	sed -e "s|<sasl.h>|<sasl/sasl.h>|" -i Modules/LDAPObject.c

	use ssl && mylibs="${mylibs} ssl crypto"
	sed -e "s|^libs = .*|libs = lber resolv ${mylibs}|" \
		-e "s|^compile.*|compile = 0|" \
		-e "s|^optimize.*|optimize = 0|" \
		-i setup.cfg || die "error setting up libs in setup.cfg"
}
