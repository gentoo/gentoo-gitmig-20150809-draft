# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Prakash Shetty <crux@gentoo.org>

S=${WORKDIR}/${P}
DESCRIPTION="an extremely powerful ICCCM-compliant multiple virtual desktop window manager"
SRC_URI="ftp://ftp.fvwm.org/pub/fvwm/version-2/${P}.tar.bz2"
HOMEPAGE="http://www.fvwm.org/"

DEPEND="virtual/glibc
	>=sys-libs/readline-4.1
	>=x11-libs/gtk+-1.2.10
	gnome? ( >=gnome-base/gnome-libs-1.2.13 )"

src_compile() {
    local myconf
    if [ -n "$( use gnome )" ]
    then
	myconf="--with-gnome"
    else
	myconf="--without-gnome"
    fi
    try ./configure --prefix=/usr/X11R6 --libexecdir=/usr/X11R6/lib \
	--mandir=/usr/share/man --infodir=/usr/share/info --host=${CHOST} ${myconf}
    try make
}

src_install () {

    try make DESTDIR=${D} install
    exeinto /usr/X11R6/bin/wm
    doexe ${FILESDIR}/fvwm

}
