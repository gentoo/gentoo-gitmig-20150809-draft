# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbkeys/bbkeys-0.8.2.ebuild,v 1.1 2001/08/29 15:17:38 lamer Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Use keyboard shortcuts in the blackbox wm"
SRC_URI="http://movingparts.thelinuxcommunity.org/bbkeys/${A}"
HOMEPAGE="http://movingparts.thelinuxcommunity.org"

DEPEND=">=x11-wm/blackbox-0.61"

src_compile() {

    try ./configure --prefix=/usr/X11R6 --host=${CHOST}
    try emake

}

src_install () {

    try make DESTDIR=${D} install
    cd /usr/X11R6/bin/wm
    cp blackbox blackbox.bak
    sed -e s:.*blackbox:"exec /usr/X11R6/bin/bbkeys \&\n&": blackbox.bak > blackbox
}

