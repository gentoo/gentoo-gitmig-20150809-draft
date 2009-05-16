# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ccid/ccid-1.3.5.ebuild,v 1.4 2009/05/16 07:36:40 robbat2 Exp $

STUPID_NUM="2330"
DESCRIPTION="CCID free software driver"
HOMEPAGE="http://pcsclite.alioth.debian.org/ccid.html"
SRC_URI="http://alioth.debian.org/download.php/${STUPID_NUM}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="twinserial nousb"
RDEPEND="!nousb? ( >=sys-apps/pcsc-lite-1.3.3 =virtual/libusb-0* )"

src_compile() {
	local myconf

	use nousb && myconf="${myconf} --disable-pcsclite"

	econf \
		LEX=: \
		--docdir="/usr/share/doc/${PF}" \
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
