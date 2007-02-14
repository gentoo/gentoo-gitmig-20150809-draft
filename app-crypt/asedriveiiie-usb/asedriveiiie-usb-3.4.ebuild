# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/asedriveiiie-usb/asedriveiiie-usb-3.4.ebuild,v 1.3 2007/02/14 20:59:38 alonbl Exp $

DESCRIPTION="ASEDriveIIIe USB Card Reader"
HOMEPAGE="http://www.athena-scs.com"
SRC_URI="http://www.athena-scs.com/downloads/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
RDEPEND=">=sys-apps/pcsc-lite-1.3.0
	>=dev-libs/libusb-0.1.10"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm ifdhandler.h
}

src_compile() {
	CFLAGS="${CFLAGS} -DIFDHANDLERv2" econf || die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die

	dodoc LICENSE
	dodoc README

	elog "NOTICE:"
	elog "You should restart pcscd."
}

