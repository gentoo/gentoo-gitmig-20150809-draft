# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ldap/python-ldap-2.0.0_pre13.ebuild,v 1.1 2003/07/01 10:35:12 liquidx Exp $

inherit distutils

IUSE="sasl ssl"
MY_P=${P/_pre/pre}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Various LDAP-related Python modules"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://python-ldap.sourceforge.net/"

DEPEND="virtual/python
	>=net-nds/openldap-2.0.11"
SLOT="0"
LICENSE="public-domain" # NOTE: win32 section is under questionable license
KEYWORDS="~x86 ~sparc ~alpha"

src_unpack() {
	unpack ${A}	
	cd ${S}
	sed -e "s|/usr/local/openldap.*/lib|/usr/lib|" \
	    -e "s|/usr/local/openldap.*/include|/usr/include|" \
		-i setup.cfg || die "error fixing setup.cfg"

	local mylibs
	use sasl && mylibs="${mylibs} sasl2"
	use ssl && mylibs="${mylibs} ssl crypto"
	sed -e "s|^libs = .*|libs = ldap_r lber resolv ${mylibs}|" -i setup.cfg \
		|| die "error setting up libs in setup.cfg"

}

