# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pam_krb5/pam_krb5-1.0.ebuild,v 1.8 2002/08/16 02:36:53 murphy Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Pam module for MIT Kerberos V"
SRC_URI="http://www.fcusack.com/soft/${P}.tar.gz"
HOMEPAGE="http://www.fcusack.com"

SLOT="0"
LICENSE="BSD GPL-2 as-is"
KEYWORDS="x86 sparc sparc64"

DEPEND="app-crypt/krb5
	sys-libs/pam"

src_compile() {
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff || die
	make CFLAGS="$CFLAGS" || die
}

src_install () {
	exeinto /lib/security
	doexe pam_krb5.so.1
	dosym /lib/security/pam_krb5.so.1 /lib/security/pam_krb5.so
	
	doman pam_krb5.5
	dodoc COPYRIGHT README TODO
}
