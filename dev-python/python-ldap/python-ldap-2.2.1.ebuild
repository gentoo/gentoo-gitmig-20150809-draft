# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ldap/python-ldap-2.2.1.ebuild,v 1.7 2007/04/02 15:37:31 armin76 Exp $

inherit distutils

P_DOC="html-python-ldap-docs-2.0.3"

DESCRIPTION="Various LDAP-related Python modules"
SRC_URI="mirror://sourceforge/python-ldap/${P}.tar.gz
	doc? ( mirror://sourceforge/python-ldap/${P_DOC}.tar.gz )"
HOMEPAGE="http://python-ldap.sourceforge.net/"
SLOT="0"
LICENSE="PYTHON"
KEYWORDS="~alpha amd64 hppa ia64 ~ppc ppc64 sparc x86"
IUSE="doc sasl ssl"

DEPEND=">=net-nds/openldap-2.2
	sasl? ( dev-libs/cyrus-sasl )"

PYTHON_MODNAME="ldap"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Note: we can't add /usr/lib and /usr/lib/sasl2 to library_dirs due to a bug in py2.4
	sed -e "s:^library_dirs =.*:library_dirs =:" \
		-e "s:^include_dirs =.*:include_dirs = ${ROOT}usr/include:" \
		-e "s:\(extra_compile_args =\).*:\1\nextra_link_args = -Wl,-rpath=${ROOT}usr/lib -Wl,-rpath=${ROOT}usr/lib/sasl2:" \
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
	if use doc ; then
		dohtml -r "${WORKDIR}/${P_DOC/html-/}"/*
		insinto /usr/share/doc/${PF}
		doins -r Demo
	fi
}
