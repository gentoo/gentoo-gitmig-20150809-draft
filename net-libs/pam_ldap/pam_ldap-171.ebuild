# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/pam_ldap/pam_ldap-171.ebuild,v 1.3 2004/11/08 09:14:15 mr_bones_ Exp $

DESCRIPTION="PAM LDAP Module"
HOMEPAGE="http://www.padl.com/OSS/pam_ldap.html"
SRC_URI="http://www.padl.com/download/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~hppa ~alpha"
IUSE="ssl"
DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/pam-0.72
	>=net-nds/openldap-1.2.11"

src_compile() {
	aclocal
	autoconf
	automake --add-missing

	econf --with-ldap-lib=openldap `use_enable ssl` || die
	emake || die
}

src_install() {
	exeinto /lib/security
	doexe pam_ldap.so

	dodoc pam.conf ldap.conf ldapns.schema chsh chfn certutil
	dodoc ChangeLog COPYING.* CVSVersionInfo.txt README AUTHORS ns-pwd-policy.schema
	docinto pam.d
	dodoc pam.d/*
}
