# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/xscreensaver/xscreensaver-3.29.ebuild,v 1.1 2001/03/02 02:13:14 pete Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="a modular screensaver for X11"
SRC_URI="http://www.jwz.org/xscreensaver/${A}"
HOMEPAGE="http://www.jwz.org/xscreensaver/"

DEPEND=">=x11-base/xfree-4.0
	>=media-libs/gle-3.0.1
	>=x11-libs/gtk+-1.2.8
	>=gnome-base/gnome-core-1.2.0"

src_compile() {
    if [ "$( use gnome )" ]
    then
	try ./configure --prefix=/usr/X11R6 --host=${CHOST} \
	    --enable-subdir=/usr/X11R6/lib/xscreensaver \
	    --with-mit-ext --with-dpms-ext --with-xf86vmode-ext \
	    --with-proc-interrupts --with-gtk --with-gnome \
	    --with-gl --with-gle --with-xpm --with-xshm-ext \
	    --with-xdbe-ext --enable-locking
    else
	try ./configure --prefix=/usr/X11R6 --host=${CHOST} \
	    --enable-subdir=/usr/X11R6/lib/xscreensaver \
	    --with-mit-ext --with-dpms-ext --with-xf86vmode-ext \
	    --with-proc-interrupts --with-gtk --with-gl \
	    --with-gle --with-xpm --with-xshm-ext --with-xdbe-ext \
	    --enable-locking
    fi
    try make
}

src_install () {
    try make install_prefix=${D} install
}

