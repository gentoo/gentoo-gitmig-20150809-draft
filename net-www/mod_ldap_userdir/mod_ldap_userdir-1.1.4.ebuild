# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_ldap_userdir/mod_ldap_userdir-1.1.4.ebuild,v 1.4 2004/09/03 23:24:08 pvdabeel Exp $
IUSE="apache2"

DESCRIPTION="Apache module that enables ~/public_html from an LDAP directory."
HOMEPAGE="http://horde.net/~jwm/software/mod_ldap_userdir/"
KEYWORDS="x86 ppc"

S=${WORKDIR}/${P}
SRC_URI="http://horde.net/~jwm/software/mod_ldap_userdir/${P}.tar.gz"

DEPEND="=net-www/apache-1*
		apache2? ( =net-www/apache-2* )
		ssl? ( dev-libs/openssl )
		net-nds/openldap"

LICENSE="GPL-1"
SLOT="0"

src_compile() {
	local myconf
	if use apache2; then
		myconf="${myconf} --with-apxs2=/usr/sbin/apxs2"
	else
		myconf="${myconf} --with-apxs=/usr/sbin/apxs"
	fi

	use ssl && myconf="${myconf} -with-tls"

	myconf="${myconf} --with-activate"
	./configure ${myconf} || die "Configure failed"
	make clean
	make || die "Make failed"
}

src_install() {
	if use apache2; then
	  exeinto /usr/lib/apache2-extramodules
	  doexe mod_ldap_userdir.so
	else
	   exeinto /usr/lib/apache-extramodules
	   doexe mod_ldap_userdir.so
	fi
	dodoc DIRECTIVES README user-ldif posixAccount-objectclass
}

pkg_postinst() {
	if use apache2; then
		einfo "Adjust /etc/apache2/conf/modules.d/47_mod_ldap_userdir.conf to match your setup and"
		einfo "add '-D LDAPuserdir' to your APACHE2_OPTS in /etc/conf.d/apache2"
		einfo "To configure the package run \"ebuild /var/db/pkg/net-www/${PF}/${PF}.ebuild config\""
	fi
}

pkg_config() {
	/usr/sbin/apacheaddmod \
			${ROOT}/etc/apache/conf/apache.conf \
			extramodules/mod_ldap_userdir.so mod_ldap_userdir.c ldap_userdir_module \
			define=LDAPuserdir addconf=conf/addon-modules/47_mod_ldap_userdir.conf
}
