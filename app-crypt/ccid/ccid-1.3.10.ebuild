# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ccid/ccid-1.3.10.ebuild,v 1.3 2009/05/02 17:08:25 nixnut Exp $

STUPID_NUM="2924"
DESCRIPTION="CCID free software driver"
HOMEPAGE="http://pcsclite.alioth.debian.org/ccid.html"
SRC_URI="http://alioth.debian.org/download.php/${STUPID_NUM}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ppc ppc64 ~x86"
IUSE="twinserial nousb"

RDEPEND="!nousb? ( >=sys-apps/pcsc-lite-1.3.3 >=dev-libs/libusb-0.1.4 )"
DEPEND="${RDEPEND}"

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
