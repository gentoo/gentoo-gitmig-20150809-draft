# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cyberjack/cyberjack-3.3.5-r2.ebuild,v 1.3 2011/08/05 21:42:44 hwoarang Exp $

EAPI=2
inherit autotools eutils flag-o-matic

MY_P=ctapi-${P}

DESCRIPTION="REINER SCT cyberJack pinpad/e-com USB user space driver library"
HOMEPAGE="http://www.reiner-sct.de/ http://www.libchipcard.de/"
SRC_URI="http://support.reiner-sct.de/downloads/LINUX/V${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="fox pcsc-lite +udev"

RDEPEND="virtual/libusb:1
	fox? ( >=x11-libs/fox-1.6 )
	pcsc-lite? ( sys-apps/pcsc-lite	)"
DEPEND="${RDEPEND}
	pcsc-lite? ( dev-util/pkgconfig )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	use udev && enewgroup ${PN}
}

src_prepare() {
	if use udev; then
		epatch "${FILESDIR}"/${PN}-3.3.2-udev.patch
		cp "${FILESDIR}"/cyberjack.sh etc/udev/ || die
		cp "${FILESDIR}"/cyberjack.rules-r1 etc/udev/rules.new || die
		AT_M4DIR="m4" eautoreconf
	fi
}

src_configure() {
	append-flags -fno-strict-aliasing

	local with_usbdropdir
	use pcsc-lite && with_usbdropdir="--with-usbdropdir=$(pkg-config libpcsclite --variable=usbdropdir)"

	econf \
		--sysconfdir=/etc/${PN} \
		--disable-dependency-tracking \
		--disable-hal \
		$(use_enable pcsc-lite pcsc) \
		$(use_enable fox) \
		$(use_enable udev) \
		${with_usbdropdir}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS doc/README.txt
	use udev && rm -rf "${D}"/usr/hotplug
}

pkg_postinst() {
	local conf="/etc/${PN}/${PN}.conf"
	elog
	elog "To configure logging, key beep behaviour etc. you need to"
	elog "copy ${conf}.default"
	elog "to ${conf}"
	elog "and modify the latter as needed."
	elog
	if use udev; then
		elog "To be able to use the cyberJack device, you need to"
		elog "be a member of the group 'cyberjack' which has just"
		elog "been added to your system. You can add your user to"
		elog "the group by running the following command as root:"
		elog
		elog "  gpasswd -a youruser cyberjack"
		elog
		elog "Please be aware that you need to re-login to your"
		elog "system for the group membership to take effect."
		elog
	fi
}
