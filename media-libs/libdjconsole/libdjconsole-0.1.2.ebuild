# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdjconsole/libdjconsole-0.1.2.ebuild,v 1.2 2008/01/13 18:22:29 aballier Exp $

DESCRIPTION="A driver for the DJ Console, built on top of libusb"
HOMEPAGE="http://djplay.sourceforge.net/"
SRC_URI="mirror://sourceforge/djplay/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libusb"
RDEPEND="${DEPEND}
	dev-util/pkgconfig"

src_install() {
	emake install DESTDIR="${D}" || die 'make install failed'
	dodoc ChangeLog NEWS README AUTHORS
}
