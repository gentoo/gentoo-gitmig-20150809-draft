# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <grant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-crypt/krb5/krb5-1.2.5.ebuild,v 1.1 2002/05/30 03:07:19 mjc Exp $ 

S=${WORKDIR}/${P}/src
SRC_URI="http://www.crypto-publish.org/dist/mit-kerberos5/${P}.tar.gz"
DESCRIPTION="MIT Kerberos V (set up for pam)"
HOMEPAGE="http://crypto-publish.org"

DEPEND="virtual/glibc"


src_compile() {

	patch -p0 < ${FILESDIR}/${PN}-1.2.2-gentoo.diff

    ./configure --with-krb4 --enable-shared --prefix=/usr \
		--mandir=/usr/share/man --host=${CHOST} \
		--localstatedir=/var/krb5kdc \
		--enable-dns \
		|| die
    mv Makefile Makefile.orig
    #Don't install the ftp, telnet, r* apps; use pam instead
    sed -e 's/ appl / /' Makefile.orig > Makefile
    emake || die

}

src_install () {

    make DESTDIR=${D} install || die
    cd ..
    dodoc README
    echo 'NOTE: ftp, telnet, r* apps not installed.  Install pam-krb5!'

}

