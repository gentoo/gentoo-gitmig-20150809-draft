# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dialup/bbppp/bbppp-0.2.2.ebuild,v 1.2 2001/08/30 17:31:35 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="blackbox ppp frontend/monitor"
SRC_URI="http://bbtools.thelinuxcommunity.org/sources/${A}"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml#bbppp"

DEPEND=">=x11-wm/blackbox-0.61"

src_compile() {

	try ./configure --prefix=/usr/X11R6 --host=${CHOST}
	try emake

}

src_install () {

	try make DESTDIR=${D} install
	dodoc README COPYING AUTHORS BUGS INSTALL ChangeLog NEWS TODO data/README.bbppp
	cd /usr/X11R6/bin/wm
	cp blackbox blackbox.bak
	sed -e s:.*blackbox:"exec /usr/X11R6/bin/bbppp \&\n&": blackbox.bak > blackbox
}

