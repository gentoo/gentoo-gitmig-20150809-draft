# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/vile/vile-9.2.ebuild,v 1.1 2000/12/22 17:11:44 jerry Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="VI Like Emacs -- yet another full-featured vi clone"
SRC_URI="ftp://dickey.his.com/vile/${A}"
HOMEPAGE="http://www.clark.net/pub/dickey/vile/vile.html"

DEPEND=">=sys-devel/perl-5.6.0
        >=sys-libs/glibc-2.1.3"

src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} \
        --with-perl
    try make
}

src_install () {
    cd ${S}
    try make DESTDIR=${D} install

    dodoc CHANGES* MANIFEST README
}
