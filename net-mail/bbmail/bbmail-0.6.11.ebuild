# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Craig Joly <joly@ee.ualberta.ca>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="blackbox mail notification, patched for maildir"
SRC_URI="http://bbtools.thelinuxcommunity.org/sources/${A}.tar.gz"
HOMEPAGE="http://bbtools.thelinuxcommunity.org/available.phtml"

DEPEND=">=x11-wm/blackbox-0.61"

src_unpack () {

	unpack ${P}.tar.gz
	cd ${S}
	# This is a patch for bbmail to support qmail style maildirs
	try patch -p1 < ${FILESDIR}/bbmail-qmail.patch
}

src_compile() {

    try ./configure --prefix=/usr/X11R6 --host=${CHOST}
    try emake

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README TODO data/README.bbmail
	cd /usr/X11R6/bin/wm
	cp blackbox blackbox.bak
	sed -e s:.*blackbox:"exec /usr/X11R6/bin/bbmail \&\n&": blackbox.bak > blackbox
}
