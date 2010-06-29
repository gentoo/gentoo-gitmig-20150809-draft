# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ccid/ccid-1.3.11.ebuild,v 1.6 2010/06/29 00:20:47 arfrever Exp $

EAPI="2"

STUPID_NUM="3080"

DESCRIPTION="CCID free software driver"
HOMEPAGE="http://pcsclite.alioth.debian.org/ccid.html"
SRC_URI="http://alioth.debian.org/download.php/${STUPID_NUM}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 x86"
IUSE="twinserial +usb"

DEPEND=">=sys-apps/pcsc-lite-1.3.3
	usb? ( virtual/libusb:0 )"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		LEX=: \
		--docdir="/usr/share/doc/${PF}" \
		--enable-udev \
		$(use_enable twinserial) \
		$(use_enable usb libusb)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS
	insinto /etc/udev/rules.d
	newins src/pcscd_ccid.rules 60-pcscd_ccid.rules
}
