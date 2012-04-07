# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ccid/ccid-1.4.6.ebuild,v 1.2 2012/04/07 20:18:18 flameeyes Exp $

EAPI="4"

STUPID_NUM="3711"

inherit eutils

DESCRIPTION="CCID free software driver"
HOMEPAGE="http://pcsclite.alioth.debian.org/ccid.html"
SRC_URI="http://alioth.debian.org/download.php/${STUPID_NUM}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86"
IUSE="twinserial +usb"

DEPEND=">=sys-apps/pcsc-lite-1.8.3
	usb? ( virtual/libusb:1 )"
RDEPEND="${DEPEND}"

DOCS=( README AUTHORS )

src_prepare() {
	sed -i -e 's:GROUP="pcscd":ENV{PCSCD}="1":' \
		src/92_pcscd_ccid.rules || die
}

src_configure() {
	econf \
		LEX=: \
		--docdir="/usr/share/doc/${PF}" \
		$(use_enable twinserial) \
		$(use_enable usb libusb)
}

src_install() {
	default

	if use kernel_linux; then
		insinto /lib/udev/rules.d
		newins src/92_pcscd_ccid.rules 92-pcsc-ccid.rules
	fi
}
