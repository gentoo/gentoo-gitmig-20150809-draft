# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/asedriveiiie-usb/asedriveiiie-usb-3.4.ebuild,v 1.6 2009/05/16 07:00:33 robbat2 Exp $

DESCRIPTION="ASEDriveIIIe USB Card Reader"
HOMEPAGE="http://www.athena-scs.com"
SRC_URI="http://www.athena-scs.com/downloads/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="~x86"
RDEPEND=">=sys-apps/pcsc-lite-1.3.0
	=virtual/libusb-0*"
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
