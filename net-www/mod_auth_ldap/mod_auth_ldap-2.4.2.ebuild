# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_ldap/mod_auth_ldap-2.4.2.ebuild,v 1.2 2004/04/04 22:26:57 zul Exp $

DESCRIPTION="Apache module for LDAP authorizaion"
HOMEPAGE="http://www.muquit.com/muquit/software/mod_auth_ldap/mod_auth_ldap.html"
KEYWORDS="x86 ~ppc ~sparc"

#watch out for this thing; no version number ...
#SRC_URI="http://www.muquit.com/muquit/software/mod_auth_ldap/${PN}.tar.gz"
#---> as of 2.4.2 still no version number, doing it the hard way, sigh.
SRC_URI="mirror://gentoo/${P}.tar.bz2"

DEPEND="=net-www/apache-1* >=net-nds/openldap-2.0.25"
LICENSE="as-is"
SLOT="0"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	patch -p1 <${FILESDIR}/${P}-register.patch || die
}

src_compile() {
	apxs -lresolv -lldap -llber -c mod_auth_ldap.c || die
}

src_install() {
	exeinto /usr/lib/apache-extramodules
	doexe mod_auth_ldap.so

	insinto /etc/apache/conf/addon-modules
	doins ${FILESDIR}/mod_auth_ldap.conf

	dodoc README
	dohtml mod_auth_ldap.html
}

pkg_postinst() {
	einfo
	einfo "Execute the command:"
	einfo " \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
	einfo " to auto-update apache.conf with supporting statements."
	einfo " Then edit /etc/conf.d/apache accordingly."
	einfo " You can find config examples here: ${HOMEPAGE}."
	einfo
}

pkg_config() {
	${ROOT}/usr/sbin/apacheaddmod \
		${ROOT}/etc/apache/conf/apache.conf \
		extramodules/mod_auth_ldap.so mod_auth_ldap.c ldap_auth_module \
		define=AUTH_LDAP addconf=conf/addon-modules/mod_auth_ldap.conf
	:;
}
