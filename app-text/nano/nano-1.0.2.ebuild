# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Prakash Shetty (Crux) <ps@gnuos.org>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Clone of PICO with more Fuctions in a smaller Size"
SRC_URI="http://www.nano-editor.org/dist/v1.0/${A}"
HOMEPAGE="http://www.nano-editor.org"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/ncurses-5.2"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --enable-extra
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc COPYING ChangeLog README 
}
