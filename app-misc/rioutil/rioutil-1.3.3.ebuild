# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rioutil/rioutil-1.3.3.ebuild,v 1.4 2004/03/15 07:50:06 mr_bones_ Exp $

DESCRIPTION="Command line tools for transfering mp3s to and from a Rio 600, 800, and Nike PSA/Play"
HOMEPAGE="http://rioutil.sourceforge.net/"
SRC_URI="mirror://sourceforge/rioutil/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/zlib"

src_compile() {
	econf \
		--disable-dependency-tracking \
		--with-usbdevfs || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO || die "dodoc failed"
}
