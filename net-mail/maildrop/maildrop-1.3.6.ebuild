# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry A! <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/maildrop/maildrop-1.3.6.ebuild,v 1.1 2001/12/19 07:40:39 jerrya Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Mail delivery agent/filter"
SRC_URI="http://download.sourceforge.net/courier/${P}.tar.gz"

HOMEPAGE="http://www.flounder.net/~mrsam/maildrop/index.html"

DEPEND=">=sys-libs/gdbm-1.8.0
        virtual/glibc
        sys-devel/perl"

PROVIDE="virtual/mda"


src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--with-etcdir=/etc/maildrop \
		--with-default-maildrop=./.maildir/ \
		--disable-tempdir --enable-syslog=1 \
		--enable-maildirquota \
		--enable-userdb || die
        
	make || die
}

src_install() {
	make install prefix=${D} bindir=${D}/usr/bin \
        mandir=${D}/usr/share/man htmldir=${D}/usr/doc/${P} || die

	dodir /etc/maildrop
}
