# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/serdisplib/serdisplib-1.97.2.ebuild,v 1.1 2006/12/18 12:52:05 jokey Exp $

DESCRIPTION="Library to drive serial/parallel/usb displays with built-in controllers"
HOMEPAGE="http://serdisplib.sourceforge.net/"
SRC_URI="mirror://sourceforge/serdisplib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="usb"

DEPEND="media-libs/gd
	usb? ( dev-libs/libusb )"
RDEPEND="${DEPEND}"

src_compile() {
	econf \
		--prefix=${D}/usr \
		$(use_enable usb libusb) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS HISTORY README TODO
}
