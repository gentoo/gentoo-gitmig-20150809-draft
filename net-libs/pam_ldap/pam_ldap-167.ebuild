# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/pam_ldap/pam_ldap-167.ebuild,v 1.2 2004/03/30 01:12:30 pylon Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PAM LDAP Module"
HOMEPAGE="http://www.padl.com/OSS/pam_ldap.html"
SRC_URI="http://www.padl.com/download/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2 | LGPL-2"
KEYWORDS="~x86 ~sparc ~ppc"
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
	dodoc ChangeLog COPYING.* CVSVersionInfo.txt README AUTHORS INSTALL
	docinto pam.d
	dodoc pam.d/*
}
