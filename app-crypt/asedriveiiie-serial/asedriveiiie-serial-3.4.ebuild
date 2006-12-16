# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/asedriveiiie-serial/asedriveiiie-serial-3.4.ebuild,v 1.1 2006/12/16 11:05:13 alonbl Exp $

DESCRIPTION="ASEDriveIIIe Serial Card Reader"
HOMEPAGE="http://www.athena-scs.com"
SRC_URI="http://www.athena-scs.com/downloads/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
RDEPEND=">=sys-apps/pcsc-lite-1.3.0
	>=dev-libs/libusb-0.1.10"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

src_install() {
	local conf="/etc/reader.conf.d/${PN}.conf"

	make install DESTDIR="${D}" || die

	dodoc LICENSE
	dodoc README

	dodir "$(dirname "${conf}")"
	insinto "$(dirname "${conf}")"
	newins "etc/reader.conf" "$(basename "${conf}")"

	einfo "NOTICE:"
	einfo "1. update ${conf} file"
	einfo "2. run update-reader.conf, yes this is a command..."
	einfo "3. restart pcscd"
}

pkg_postrm() {
	#
	# Without this, pcscd will not start next time.
	#
	local conf="/etc/reader.conf.d/${PN}.conf"
	if ! [ -f "$(grep LIBPATH "${conf}" | sed 's/LIBPATH *//' | sed 's/ *$//g')" ]; then
		rm "${conf}"
		update-reader.conf
		einfo "NOTICE:"
		einfo "You need to restart pcscd"
	fi
}

