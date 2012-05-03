# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/asekey/asekey-3.4.ebuild,v 1.3 2012/05/03 18:16:40 jdhore Exp $

DESCRIPTION="ASEKey USB SIM Card Reader"
HOMEPAGE="http://www.athena-scs.com"
SRC_URI="http://www.athena-scs.com/downloads/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"
RDEPEND=">=sys-apps/pcsc-lite-1.3.0
	=virtual/libusb-0*"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install() {
	local conf="/etc/reader.conf.d/${PN}.conf"

	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ChangeLog README

	dodir "$(dirname "${conf}")"
	insinto "$(dirname "${conf}")"
	newins "etc/reader.conf" "$(basename "${conf}")"
}

pkg_postinst() {
	elog "NOTICE:"
	elog "1. Run update-reader.conf, yes this is a command..."
	elog "2. Restart pcscd"
}

pkg_postrm() {
	#
	# Without this, pcscd will not start next time.
	#
	local conf="/etc/reader.conf.d/${PN}.conf"
	if ! [[ -f "${conf}" && -f "$(grep LIBPATH "${conf}" | sed 's/LIBPATH *//' | sed 's/ *$//g' | head -n 1)" ]]; then
		[[ -f "${conf}" ]] && rm "${conf}"
		update-reader.conf
		elog "NOTICE:"
		elog "You need to restart pcscd"
	fi
}
