# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.6.4-r1.ebuild,v 1.1 2001/11/10 00:15:08 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An object-oriented scripting language"
SRC_URI="ftp://ftp.netlab.co.jp/pub/lang/ruby/${P}.tar.gz"
HOMEPAGE="http://www.ruby-lang.org/"

DEPEND=">=sys-libs/glibc-2.1.3
        >=sys-libs/gdbm-1.8.0
        >=sys-libs/readline-4.1
        >=sys-libs/ncurses-5.2"

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man
	assert

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc COPYING* ChangeLog MANIFEST README* ToDo
}
