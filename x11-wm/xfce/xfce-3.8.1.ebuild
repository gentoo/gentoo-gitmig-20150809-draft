# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <ben@sistina.com>
# /home/cvsroot/gentoo-x86/x11-wm/blackbox/blackbox-0.61.1.ebuild,v 1.1 2001/04/20 18:51:22 drobbins Exp
 
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="XFce is a lightweight desktop environment for various UNIX systems."
SRC_URI="http://prdownloads.sourceforge.net/xfce/${A}"
HOMEPAGE="http://www.xfce.org/"

DEPEND="virtual/x11
        >=x11-libs/gtk+-1.2
	>=media-libs/imlib-1.9.10"

src_compile() {
	try ./configure --prefix=/usr/X11R6 --mandir=/usr/X11R7/share/man --host=${CHOST} 
    try make
}

src_install () {
    try make DESTDIR=${D} install
    dodoc ChangeLog* AUTHORS LICENSE README* TODO*
    exeinto /usr/X11R6/bin/wm
    doexe ${FILESDIR}/xfce
}
