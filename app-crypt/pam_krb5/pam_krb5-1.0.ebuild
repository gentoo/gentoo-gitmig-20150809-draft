# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pam_krb5/pam_krb5-1.0.ebuild,v 1.15 2003/10/01 09:39:25 aliz Exp $

DESCRIPTION="Pam module for MIT Kerberos V"
SRC_URI="http://www.fcusack.com/soft/${P}.tar.gz"
HOMEPAGE="http://www.fcusack.com/"

SLOT="0"
LICENSE="BSD GPL-2 as-is"
KEYWORDS="x86 sparc ppc"

DEPEND="app-crypt/mit-krb5
	sys-libs/pam"

S=${WORKDIR}/${PN}

src_compile() {
	epatch ${FILESDIR}/${P}-gentoo.diff
	make CFLAGS="$CFLAGS" || die
}

src_install() {
	exeinto /lib/security
	doexe pam_krb5.so.1
	dosym /lib/security/pam_krb5.so.1 /lib/security/pam_krb5.so

	doman pam_krb5.5
	dodoc COPYRIGHT README TODO
}
