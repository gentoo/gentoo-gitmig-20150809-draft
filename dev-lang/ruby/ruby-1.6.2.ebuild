# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.6.2.ebuild,v 1.4 2001/06/24 02:20:30 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An object-oriented scripting language"
SRC_URI="ftp://ftp.netlab.co.jp/pub/lang/ruby/${A}"
HOMEPAGE="http://www.ruby-lang.org/"

DEPEND=">=sys-libs/glibc-2.1.3
        >=sys-libs/gdbm-1.8.0
        >=sys-libs/readline-4.1
        >=sys-libs/ncurses-5.2"

src_compile() {
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
    try make
}

src_install () {
    try make DESTDIR=${D} install
    COPYING* ChangeLog MANIFEST README* ToDo
}
