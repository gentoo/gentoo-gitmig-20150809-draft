# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ccid/ccid-1.1.0-r1.ebuild,v 1.1 2006/12/28 20:50:48 alonbl Exp $

inherit eutils autotools

DL_NUM="1740"
DESCRIPTION="CCID free software driver"
HOMEPAGE="http://pcsclite.alioth.debian.org/ccid.html"
SRC_URI="http://alioth.debian.org/download.php/${DL_NUM}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="chipcard2 twinserial"
RDEPEND="
	!chipcard2? (
		>=sys-apps/pcsc-lite-1.3.2
		>=dev-libs/libusb-0.1.4
	)
	chipcard2? sys-libs/libchipcard"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-build.patch"
	eautoreconf
}

src_compile() {
	local myconf

	# bug 131421 - allow ccid to work with sys-libs/libchipcard
	use chipcard2 && myconf="${myconf} \
		--enable-usbdropdir=/usr/lib/chipcard2-server/lowlevel/ifd \
		--enable-ccidtwindir=/usr/lib/chipcard2-server/lowlevel/ifd"

	use nousb && myconf="${myconf} --disable-pcsclite"

	econf \
		${myconf} \
		$(use_enable twinserial) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "Cannot install"
	dodoc README AUTHORS
}
