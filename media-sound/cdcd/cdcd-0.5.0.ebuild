# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdcd/cdcd-0.5.0.ebuild,v 1.4 2001/04/29 18:42:54 achim Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="a simple yet powerful command line cd player"
SRC_URI="http://cdcd.undergrid.net/source_archive/${A}"
HOMEPAGE="http://cdcd.undergrid.net/"
DEPEND=">=sys-libs/ncurses-5.0
	>=sys-libs/readline-4.0
	>=media-libs/libcdaudio-0.99.4"

src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
    try make
}

src_install () {
    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README
}

