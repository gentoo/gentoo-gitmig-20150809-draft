# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rioutil/rioutil-1.4.4.ebuild,v 1.1 2004/04/02 19:34:26 hillster Exp $

DESCRIPTION="Command line tool for transfering mp3s to and from a Rio 600, 800, Rio Riot, and Nike PSA/Play"
HOMEPAGE="http://rioutil.sourceforge.net/"
SRC_URI="mirror://sourceforge/rioutil/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/zlib"

src_compile() {
	local myconf="--with-usbdevfs"

	econf ${myconf}
	emake || die "compile failure"
}

src_install() {
	einstall

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
