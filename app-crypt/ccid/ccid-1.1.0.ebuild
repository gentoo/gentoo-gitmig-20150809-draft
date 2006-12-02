# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ccid/ccid-1.1.0.ebuild,v 1.2 2006/12/02 23:33:04 beandog Exp $

inherit eutils

DL_NUM="1740"
DESCRIPTION="CCID free software driver"
HOMEPAGE="http://pcsclite.alioth.debian.org/ccid.html"
SRC_URI="http://alioth.debian.org/download.php/${DL_NUM}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="chipcard2"
RDEPEND=">=sys-apps/pcsc-lite-1.3.2
	>=dev-libs/libusb-0.1.4"

src_compile() {
	local myconf

	# bug 131421 - allow ccid to work with sys-libs/libchipcard
	use chipcard2 && myconf="${myconf} --disable-pcsclite \
		--enable-usbdropdir=/usr/lib/chipcard2-server/lowlevel/ifd \
		--enable-ccidtwindir=/usr/lib/chipcard2-server/lowlevel/ifd"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "Cannot install"
	dodoc README AUTHORS
}
