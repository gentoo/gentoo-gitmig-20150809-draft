# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pam_krb5/pam_krb5-1.0.ebuild,v 1.5 2002/07/11 06:30:11 drobbins Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Pam module for MIT Kerberos V"
SRC_URI="http://www.fcusack.com/soft/${P}.tar.gz"
HOMEPAGE="http://www.fcusack.com"

DEPEND="app-crypt/krb5
        sys-libs/pam"

src_compile() {
    patch -p0 < ${FILESDIR}/${P}-gentoo.diff    
    try make CFLAGS="$CFLAGS"
}

src_install () {

    exeinto /lib/security
    doexe pam_krb5.so.1
    dosym /lib/security/pam_krb5.so.1 /lib/security/pam_krb5.so
    
    doman pam_krb5.5
    dodoc COPYRIGHT README TODO

}

