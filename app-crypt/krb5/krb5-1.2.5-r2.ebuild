# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/krb5/krb5-1.2.5-r2.ebuild,v 1.2 2002/08/02 20:58:49 seemant Exp $

S=${WORKDIR}/${P}/src
SRC_URI="http://www.crypto-publish.org/dist/mit-kerberos5/${P}.tar.gz"
DESCRIPTION="MIT Kerberos V (set up for pam)"
HOMEPAGE="http://web.mit.edu/kerberos/www/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_compile() {

	patch -p0 < ${FILESDIR}/${PN}-1.2.2-gentoo.diff || die

	cd ${S}/lib/rpc
	patch -p0 < ${FILESDIR}/${P}-r2.patch || die
	cd ${S}

	econf \
		--with-krb4 \
		--enable-shared \
		--enable-dns || die
	mv Makefile Makefile.orig
	#Don't install the ftp, telnet, r* apps; use pam instead
	sed -e 's/ appl / /' Makefile.orig > Makefile
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	cd ..
	dodoc README
	echo 'NOTE: ftp, telnet, r* apps not installed.  Install pam-krb5!'
}
