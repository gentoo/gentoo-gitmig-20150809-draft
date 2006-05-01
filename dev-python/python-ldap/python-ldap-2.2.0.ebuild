# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ldap/python-ldap-2.2.0.ebuild,v 1.1 2006/05/01 13:45:30 carlo Exp $

inherit distutils

#MY_P=${P/_pre/pre}
#S=${WORKDIR}/${MY_P}
P_DOC="html-python-ldap-docs-2.0.3" # no newer docs available

DESCRIPTION="Various LDAP-related Python modules"
SRC_URI="mirror://sourceforge/python-ldap/${P}.tar.gz
	doc? ( mirror://sourceforge/python-ldap/${P_DOC}.tar.gz )"
HOMEPAGE="http://python-ldap.sourceforge.net/"

DEPEND="virtual/python
	>=net-nds/openldap-2.2
	sasl? ( dev-libs/cyrus-sasl )"

SLOT="0"
LICENSE="PYTHON"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc sasl ssl"

PYTHON_MODNAME="ldap"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp setup.cfg setup.cfg.orig
	sed -e "s:^library_dirs =.*:library_dirs = ${ROOT}/usr/lib ${ROOT}/usr/lib/sasl2:" \
		-e "s:^include_dirs =.*:include_dirs = ${ROOT}/usr/include:" \
		-i setup.cfg || die "error fixing setup.cfg"

	local mylibs="ldap"
	if use sasl ; then
		use ssl && mylibs="ldap_r"
		mylibs="${mylibs} sasl2"
	fi
	use ssl && mylibs="${mylibs} ssl crypto"

	# Fixes bug #25693
	sed -e "s|<sasl.h>|<sasl/sasl.h>|" -i Modules/LDAPObject.c

	sed -e "s:^libs = .*:libs = lber resolv ${mylibs}:" \
		-e "s:^compile.*:compile = 0:" \
		-e "s:^optimize.*:optimize = 0:" \
		-i setup.cfg || die "error setting up libs in setup.cfg"
}

src_install() {
	distutils_src_install
	use doc && dohtml -r ${WORKDIR}/${P_DOC/html-/}/*
}