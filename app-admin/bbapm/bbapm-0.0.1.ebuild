# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Craig Joly <joly@ee.ualberta.ca>
# $Header: /var/cvsroot/gentoo-x86/app-admin/bbapm/bbapm-0.0.1.ebuild,v 1.2 2001/08/30 17:31:35 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="blackbox advanced power management tool"
SRC_URI="http://bbtools.thelinuxcommunity.org/sources/${A}"
HOMEPAGE="http://bbtools.thelinuxcommunity.org/contrib.phtml"

DEPEND=">=x11-wm/blackbox-0.61
	>=sys-apps/apmd-3.0.1"

src_compile() {

    try ./configure --prefix=/usr/X11R6 --host=${CHOST}
    try emake

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README TODO
	cd /usr/X11R6/bin/wm
	cp blackbox blackbox.bak
	sed -e s:.*blackbox:"exec /usr/X11R6/bin/bbapm \&\n&": blackbox.bak > blackbox
}

