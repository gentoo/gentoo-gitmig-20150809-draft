# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <ben@sistina.com>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/blackbox/blackbox-0.61.1.ebuild,v 1.2 2001/05/07 15:43:53 achim Exp $
 
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="A Small fast full featured window manager for X"
SRC_URI="ftp://portal.alug.org/pub/blackbox/0.6x.x/${A}"
HOMEPAGE="http://blackbox.alug.org/"

DEPEND=">=x11-base/xfree-4.0"

src_compile() {
	try ./configure --prefix=/usr/X11R6 --host=${CHOST} --without-gnome
    try make
}

src_install () {
    try make DESTDIR=${D} install
    exeinto /usr/X11R6/bin/wm
    doexe ${FILESDIR}/blackbox
    dodoc ChangeLog* AUTHORS LICENSE README* TODO*

}
