# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/rio500/rio500-0.7-r1.ebuild,v 1.4 2002/07/25 19:18:34 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Command line tools for transfering mp3s to and from a Rio500"
SRC_URI="http://download.sourceforge.net/rio500/${P}.tar.gz"
HOMEPAGE="http://rio500.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=dev-libs/glib-1.2*"

src_compile() {
	econf \
		--with-fontpath=/usr/share/rio500/ \
		--with-id3support || die
#		--with-usbdevfs
	make || die
}

src_install () {
	einstall \
		datadir=${D}/usr/share/rio500 || die

	dodoc AUTHORS COPYING ChangeLog NEWS README TODO 
	dodoc fonts/Readme.txt
}
