# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rioutil/rioutil-1.4.2b.ebuild,v 1.7 2004/06/28 04:10:47 vapier Exp $

DESCRIPTION="Command line tools for transfering mp3s to and from a Rio 600, 800, and Nike PSA/Play"
HOMEPAGE="http://rioutil.sourceforge.net/"
SRC_URI="mirror://sourceforge/rioutil/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="sys-libs/zlib"

src_compile() {
	econf --with-usbdevfs || die "econf failed"
	emake || die "compile failure"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
