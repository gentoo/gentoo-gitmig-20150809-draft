# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/nload/nload-0.3.0.ebuild,v 1.1 2001/09/25 19:52:09 lamer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="console application which monitors network traffic and bandwidth usage in real time"
SRC_URI="http://members.tripod.de/rolandriegel/${P}.tar.gz"
HOMEPAGE="http://roland-riegel.de/nload/index_en.html"
DEPEND=""

#RDEPEND=""

src_compile() {
	try ./configure --infodir=/usr/share/info \
		--mandir=/usr/share/man --prefix=/usr --host=${CHOST}
	
	try make
}

src_install () {
	
    try make DESTDIR=${D} install
	 dodoc README INSTALL ChangeLog AUTHORS COPYING TODO
}

