# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fvwm/fvwm-2.3.28.ebuild,v 1.2 2001/05/07 15:45:41 achim Exp $

#P=
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="an extremely powerful ICCCM-compliant multiple virtual desktop window manager"
SRC_URI="ftp://ftp.fvwm.org/pub/fvwm/version-2/${A}"
HOMEPAGE="http://www.fvwm.org/"

DEPEND=">=x11-base/xfree-4.0
	>=sys-libs/readline-4.0
	>=sys-libs/ncurses-5.0
	>=x11-libs/gtk+-1.2.8
	gnome? ( >=gnome-base/gnome-libs-1.2.8 )"

src_compile() {
    if [ -n "$( use gnome )" ]
    then
	try ./configure --prefix=/usr/X11R6 --host=${CHOST} --with-gnome
    else
	try ./configure --prefix=/usr/X11R6 --host=${CHOST} --without-gnome
    fi
    try make
}

src_install () {

    try make DESTDIR=${D} install
    exeinto /usr/X11R6/bin/wm
    doexe ${FILESDIR}/fvwm

}
