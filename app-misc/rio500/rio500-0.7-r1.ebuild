# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/rio500/rio500-0.7-r1.ebuild,v 1.14 2004/06/28 04:10:27 vapier Exp $

DESCRIPTION="Command line tools for transfering mp3s to and from a Rio500"
HOMEPAGE="http://rio500.sourceforge.net/"
SRC_URI="mirror://sourceforge/rio500/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="=dev-libs/glib-1.2*"

src_compile() {
	econf \
		--with-fontpath=/usr/share/rio500/ \
		--with-id3support || die
#		--with-usbdevfs
	make || die
}

src_install() {
	einstall \
		datadir=${D}/usr/share/rio500 || die

	dodoc AUTHORS ChangeLog NEWS README TODO
	dodoc fonts/Readme.txt
}
