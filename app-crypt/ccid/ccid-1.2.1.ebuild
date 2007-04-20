# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ccid/ccid-1.2.1.ebuild,v 1.2 2007/04/20 19:06:59 hanno Exp $

inherit eutils autotools

STUPID_NUM="1880"
DESCRIPTION="CCID free software driver"
HOMEPAGE="http://pcsclite.alioth.debian.org/ccid.html"
SRC_URI="http://alioth.debian.org/download.php/${STUPID_NUM}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="twinserial nousb"
RDEPEND=">=sys-apps/pcsc-lite-1.3.3
	>=dev-libs/libusb-0.1.4"

src_compile() {
	local myconf

	use nousb && myconf="${myconf} --disable-pcsclite"

	econf \
		--enable-udev \
		${myconf} \
		$(use_enable twinserial) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "Cannot install"
	dodoc README AUTHORS
	insinto /etc/udev/rules.d
	newins src/pcscd_ccid.rules 60-pcscd_ccid.rules
}
