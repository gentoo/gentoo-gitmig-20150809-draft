# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens
# $Header: /home/blutgens/gentoo-x86/app-misc/screen.ebuild,v 1.2 2001/04/21
# 19:25 CST blutgens Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION=" Screen is a full-screen window manager that multiplexes a
physical terminal between several processes"
SRC_URI="ftp://ftp.uni-erlangen.de/pub/utilities/screen/${A}"
HOMEPAGE="http://www.gnu.org/software/screen/"

DEPEND=">=sys-libs/glibc-2.1.3
        >=sys-libs/gpm-1.19.3
        >=sys-libs/ncurses-5.2"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}\
	--mandir=/usr/share --libexecdir=/usr/lib/misc\
	--host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    insinto /etc
    doins etc/screenrc
    dodoc README ChangeLog INSTALL COPYING TODO
    docinto doc
    cd doc
    dodoc FAQ README.DOTSCREEN fdpat.ps window_to_display.ps
}

