# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fvwm/fvwm-2.3.32.ebuild,v 1.1 2001/06/04 21:58:46 achim Exp $

#P=
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="an extremely powerful ICCCM-compliant multiple virtual desktop window manager"
SRC_URI="ftp://ftp.fvwm.org/pub/fvwm/version-2/${A}"
HOMEPAGE="http://www.fvwm.org/"

DEPEND="virtual/glibc
	>=sys-libs/readline-4.1
	>=x11-libs/gtk+-1.2.8
	gnome? ( >=gnome-base/gnome-libs-1.2.8 )"

src_compile() {
    local myconf
    if [ -n "$( use gnome )" ]
    then
	myconf="--with-gnome"
    else
	myconf="--without-gnome"
    fi
    try ./configure --prefix=/usr/X11R6 --libexecdir=/usr/X11R6/lib \
	--host=${CHOST} ${myconf}
    try make
}

src_install () {

    try make DESTDIR=${D} install
    exeinto /usr/X11R6/bin/wm
    doexe ${FILESDIR}/fvwm

}
