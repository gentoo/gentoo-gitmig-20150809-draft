# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/vile/vile-9.2-r1.ebuild,v 1.3 2001/11/10 02:54:28 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="VI Like Emacs -- yet another full-featured vi clone"
SRC_URI="ftp://dickey.his.com/vile/${P}.tgz"
HOMEPAGE="http://www.clark.net/pub/dickey/vile/vile.html"

DEPEND="virtual/glibc
        sys-devel/flex
        >=sys-libs/ncurses-5.2
        perl? ( sys-devel/perl )"

RDEPEND="virtual/glibc
        >=sys-libs/ncurses-5.2"

src_compile() {
    local myconf
    if [ "`use perl`" ] ; then
      myconf="--with-perl"
    fi
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} \
        $myconf --with-ncurses
    try make
}

src_install () {

    try make DESTDIR=${D} install
    dodoc CHANGES* MANIFEST README

}
