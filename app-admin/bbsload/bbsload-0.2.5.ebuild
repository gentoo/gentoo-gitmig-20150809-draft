# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/bbsload/bbsload-0.2.5.ebuild,v 1.2 2001/08/15 19:21:25 lordjoe Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="blackbox load monitor"
SRC_URI="http://bbtools.thelinuxcommunity.org/sources/${A}"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbsload"

DEPEND=">=x11-wm/blackbox-0.61"

src_compile() {

	try ./configure --prefix=/usr/X11R6 --host=${CHOST}
	try emake

}

src_install () {

	try make DESTDIR=${D} install
	dodoc README COPYING AUTHORS BUGS INSTALL ChangeLog NEWS TODO data/README.bbsload
	cd /usr/X11R6/bin/wm
	cp blackbox blackbox.bak
	sed -e s:.*blackbox:"exec /usr/X11R6/bin/bbsload \&\n&": blackbox.bak > blackbox
}

