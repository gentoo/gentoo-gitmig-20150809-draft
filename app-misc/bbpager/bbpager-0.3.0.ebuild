# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Gontran Zepeda <gontran@gontran.net>
# Based on bbkeys*.ebuild by Joe Bormolini <lordjoe> and 
# blackbox*.ebuild by Ben Lutgens <lamer>
# $Header: /var/cvsroot/gentoo-x86/app-misc/bbpager/bbpager-0.3.0.ebuild,v 1.2 2001/08/15 19:23:57 lordjoe Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An understated pager for Blackbox."
SRC_URI="http://bbtools.windsofstorm.net/sources/${A}"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbpager"

DEPEND=">=x11-wm/blackbox-0.61"

src_compile() {

    try ./configure --prefix=/usr/X11R6 --host=${CHOST}
    try pmake

}

src_install () {

    try make DESTDIR=${D} install
    dodoc README TODO NEWS ChangeLog
    cd /usr/X11R6/bin/wm
    cp blackbox blackbox.bak
    sed -e s:.*blackbox:"exec /usr/X11R6/bin/bbpager \&\n&": blackbox.bak > blackbox
}

