# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-text/gmanedit/gmanedit-0.3.3.ebuild,v 1.1 2001/06/25 06:19:43 lamer Exp $

#P=
A=${P}.tar.bz2
S=${WORKDIR}/${P}.orig
DESCRIPTION="Gnome based manpage editor"
SRC_URI="http://gmanedit.sourceforge.net/files/${A}"
HOMEPAGE="http://gmanedit.sourceforge.net/"

DEPEND="virtual/x11
		  >=gnome-base/gnome-core-1.4.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/gmanedit-0.3.3.diff
}

src_compile() {

local myconf
if [ -z "`use gnome`" ]; then
	myconf="--with-gnome-includes=/opt/gnome/include\
				--with-gnome-libs=/opt/gnome/lib"
fi
# NOTE WILL NOT COMPILE WITHOUT --disable-nls
	 try ./configure --prefix=/opt/gnome --host=${CHOST}\
		--disable-nls  ${myconf}
    try make

}

src_install () {

    try make DESTDIR=${D} install
	dodoc AUTHORS COPYING ChangeLog TODO README NEWS
}

