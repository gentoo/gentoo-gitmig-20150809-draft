# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_ldap/mod_auth_ldap-2.4.2-r1.ebuild,v 1.1 2005/01/30 07:58:01 hollow Exp $

inherit eutils apache-module

DESCRIPTION="Apache module for LDAP authorization"
HOMEPAGE="http://www.muquit.com/muquit/software/mod_auth_ldap/mod_auth_ldap.html"
KEYWORDS="~x86 ~ppc ~sparc"

SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="as-is"
SLOT="0"
IUSE=""

DEPEND=">=net-nds/openldap-2.0.25"
RDEPEND=""

APXS1_ARGS="-lresolv -lldap -llber -c ${PN}.c"
APACHE1_MOD_FILE="${PN}.so"
APACHE1_MOD_CONF="55_${PN}"
APACHE1_MOD_DEFINE="AUTH_LDAP"

DOCFILES="README mod_auth_ldap.html"

need_apache1

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd failed"
	epatch ${FILESDIR}/${P}-register.patch || die "patch failed"
}
