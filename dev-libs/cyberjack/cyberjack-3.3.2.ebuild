# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cyberjack/cyberjack-3.3.2.ebuild,v 1.1 2009/11/19 23:20:21 wschlich Exp $

EAPI="2"

inherit eutils flag-o-matic autotools

MY_P="ctapi-${P}"

DESCRIPTION="REINER SCT cyberJack pinpad/e-com USB user space driver library"
HOMEPAGE="http://www.reiner-sct.de/ http://www.libchipcard.de/"
SRC_URI="http://support.reiner-sct.de/downloads/LINUX/V${PV}/${MY_P}.tar.gz"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="noudev pcsc-lite hal"

RDEPEND="dev-libs/libusb
	sys-fs/sysfsutils
	hal? ( sys-apps/hal )
	pcsc-lite? ( sys-apps/pcsc-lite	)"

DEPEND="${RDEPEND}
	pcsc-lite? ( dev-util/pkgconfig )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	use noudev || enewgroup "${PN}"
}

src_prepare() {
	if ! use noudev; then
		epatch "${FILESDIR}"/"${P}"-udev.patch || die "Applying udev patch failed."
		cp "${FILESDIR}"/cyberjack.sh etc/udev/ || die "Copying udev script failed."
		cp "${FILESDIR}"/cyberjack.rules etc/udev/rules.new || die "Copying udev rules failed."
	fi
	use hal || epatch "${FILESDIR}"/"${P}"-nohal.patch || die "Applying nohal patch failed."
	use pcsc-lite || epatch "${FILESDIR}"/"${P}"-nopcsc.patch || die "Applying nohal patch failed."
	AT_M4DIR="m4" eautoreconf || die "Adopting configurations failed."
}

src_configure() {
	append-flags -fno-strict-aliasing
	local with_usbdropdir=''
	use pcsc-lite && with_usbdropdir="--with-usbdropdir=$(pkg-config libpcsclite --variable=usbdropdir)"
	econf \
		--sysconfdir=/etc/"${PN}" \
		$(use_enable pcsc-lite pcsc) \
		${with_usbdropdir} \
		$(use_enable !noudev udev) \
		|| die "Configuration of package failed."
}

src_compile() {
	emake || die "Compilation of package failed."
}

src_install() {
	emake install DESTDIR="${D}" || die "Installation of package failed."
	dodoc ChangeLog NEWS doc/README.txt
	use noudev || rm -rf "${D}"/usr/hotplug
}

pkg_postinst() {
	local conf="/etc/${PN}/${PN}.conf"
	elog
	elog "To configure logging, key beep behaviour etc. you need to"
	elog "copy ${conf}.default"
	elog "to ${conf}"
	elog "and modify the latter as needed."
	elog
	if ! use noudev; then
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
