# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/vile/vile-9.2-r1.ebuild,v 1.1 2001/04/11 03:37:30 achim Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="VI Like Emacs -- yet another full-featured vi clone"
SRC_URI="ftp://dickey.his.com/vile/${A}"
HOMEPAGE="http://www.clark.net/pub/dickey/vile/vile.html"

DEPEND="virtual/glibc
        sys-devel/flex
        >=sys-libs/ncurses-5.2
        >=sys-devel/perl-5.6.0"

src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} \
        --with-perl --with-ncurses
    try make
}

src_install () {

    try make DESTDIR=${D} install
    dodoc CHANGES* MANIFEST README

}
