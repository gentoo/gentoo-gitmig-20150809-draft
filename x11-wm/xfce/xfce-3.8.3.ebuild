# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <ben@sistina.com>
# /home/cvsroot/gentoo-x86/x11-wm/blackbox/blackbox-0.61.1.ebuild,v 1.1 2001/04/20 18:51:22 drobbins Exp
# $Header: /var/cvsroot/gentoo-x86/x11-wm/xfce/xfce-3.8.3.ebuild,v 1.3 2001/08/30 17:31:36 pm Exp $

 
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="XFce is a lightweight desktop environment for various UNIX systems."
SRC_URI="http://prdownloads.sourceforge.net/xfce/${A}"
HOMEPAGE="http://www.xfce.org/"

DEPEND="virtual/x11
        >=x11-libs/gtk+-1.2
	gnome? ( >=media-libs/gdk-pixbuf-0.10 )"

if [ -z "`use gnome`" ]
then
    DEPEND="${DEPEND} >=media-libs/imlib-1.9.10"
fi

src_compile() {
    local myconf
    if [ "`use gnome`" ]
    then
	myconf="--enable-imlib=no --enable-gdk-pixbuf=/opt/gnome"
    fi
    try ./configure --prefix=/usr/X11R6 --mandir=/usr/X11R6/share/man --host=${CHOST} \
	--with-data-dir=/usr/X11R6/share/xfce --with-conf-dir=/etc/X11/xfce \
	--with-locale-dir=/usr/X11R6/share/locale ${myconf}
    try make
}

src_install () {
    try make DESTDIR=${D} install
    dodoc ChangeLog* AUTHORS LICENSE README* TODO*
    exeinto /usr/X11R6/bin/wm
    doexe ${FILESDIR}/xfce
    dodir /etc/skel/.xfce
}
