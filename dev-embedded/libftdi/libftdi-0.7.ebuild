# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/libftdi/libftdi-0.7.ebuild,v 1.1 2006/05/06 12:40:40 brix Exp $

DESCRIPTION="Userspace access to FTDI USB interface chips"
HOMEPAGE="http://www.intra2net.com/opensource/ftdi/"
SRC_URI="http://www.intra2net.com/opensource/ftdi/TGZ/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="sys-devel/libtool
	>=dev-libs/libusb-0.1.7"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc ChangeLog README
}
