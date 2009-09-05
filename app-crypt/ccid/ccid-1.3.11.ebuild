# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ccid/ccid-1.3.11.ebuild,v 1.2 2009/09/05 18:49:21 ranger Exp $

EAPI="2"

STUPID_NUM="3080"
DESCRIPTION="CCID free software driver"
HOMEPAGE="http://pcsclite.alioth.debian.org/ccid.html"
SRC_URI="http://alioth.debian.org/download.php/${STUPID_NUM}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ppc64 ~x86"
IUSE="twinserial nousb"

RDEPEND="!nousb? ( >=sys-apps/pcsc-lite-1.3.3 virtual/libusb:0 )"
DEPEND="${RDEPEND}"

src_configure() {
	local myconf

	use nousb && myconf="${myconf} --disable-pcsclite"

	econf \
		LEX=: \
		--docdir="/usr/share/doc/${PF}" \
		--enable-udev \
		${myconf} \
		$(use_enable twinserial)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS
	insinto /etc/udev/rules.d
	newins src/pcscd_ccid.rules 60-pcscd_ccid.rules
}
