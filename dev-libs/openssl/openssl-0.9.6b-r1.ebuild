# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openssl/openssl-0.9.6b-r1.ebuild,v 1.1 2001/12/27 20:02:27 woodchip Exp $

DESCRIPTION="Toolkit for SSL v2/v3 and TLS v1"
HOMEPAGE="http://www.opensl.org/"
SRC_URI="http://www.openssl.org/source/${P}.tar.gz"
S=${WORKDIR}/${P}

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND} >=sys-devel/perl-5"

src_unpack() {

	unpack ${A} ; cd ${S}

	patch -p0 < ${FILESDIR}/${P}-Makefile.org-gentoo.diff || die

	cp Configure Configure.orig
	sed -e "s/-O3/$CFLAGS/" -e "s/-m486//" Configure.orig > Configure
}

src_compile() {

	./config --prefix=/usr --openssldir=/usr/ssl shared threads || die

	make all || die "compile problem"
}

src_install() {

	dodir /usr/ssl
	make INSTALL_PREFIX=${D} install || die

	dodoc CHANGES* FAQ LICENSE NEWS README doc/*.txt
	docinto html ; dodoc doc/*.gif doc/*.html
	insinto /usr/share/emacs/site-lisp
	doins doc/c-indentation.el

	# eeek! lets not overwrite the passwd.1 manpage shall we..
	cd ${D}/usr/share/man/man1
	mv passwd.1 openssl-passwd.1
}
