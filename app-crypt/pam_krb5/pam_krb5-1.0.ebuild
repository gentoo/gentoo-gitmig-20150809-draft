# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <grant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pam_krb5/pam_krb5-1.0.ebuild,v 1.1 2001/06/21 15:26:25 g2boojum Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${PN}
DESCRIPTION="Pam module for MIT Kerberos V"
SRC_URI="http://www.fcusack.com/soft/${A}"
HOMEPAGE="http://www.fcusack.com"

DEPEND="app-crypt/krb5
        sys-libs/pam"

src_compile() {

    pwd
    patch -p0 < ${FILESDIR}/${P}-gentoo.diff    
    try make

}

src_install () {

    insinto /usr/lib/security
    doins pam_krb5.so.1
    dosym /usr/lib/security/pam_krb5.so.1 /usr/lib/security/pam_krb5.so
    into /usr
    doman pam_krb5.5
    dodoc COPYRIGHT README TODO

}

