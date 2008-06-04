# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/eagle-usb/eagle-usb-2.3.3.ebuild,v 1.7 2008/06/04 18:32:10 flameeyes Exp $

inherit linux-mod eutils autotools

DESCRIPTION="GPL Driver for Eagle Chipset powered ADSL modem"
SRC_URI="http://baud123.free.fr/eagle-usb/${PN}-${PV%.*}/${P}.tar.bz2"
HOMEPAGE="http://www.eagle-usb.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-dialup/ppp
	!net-dialup/ueagle-atm
	virtual/logger"

MODULE_NAMES="${PN}(net:${S}/driver)"
CONFIG_CHECK="!IPV6 USB"
BUILD_TARGETS=" "

pkg_setup() {
	if kernel_is ge 2 6 16; then
		eerror "This driver should be used only with kernel versions less than 2.6.16."
		eerror "Please install and use the driver included in your kernel instead."
		eerror
		eerror "The kernel option that enables the driver is CONFIG_USB_UEAGLEATM."
		eerror "You should also install firmware files available through net-dialup/ueagle-atm."
		die "unsupported kernel version"
	fi
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELSRC='${KV_DIR}'"
}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-kernel-2.6.14.patch"
	eautoreconf
}

src_compile() {
	CONFIG_FILES=Makefile.common econf --with-kernel-src="${KV_DIR}" || die "econf failed"
	for i in pppoa utils/scripts utils/eagleconnect; do
		emake -C ${i} || die "emake ${i} failed"
	done

	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	for i in driver/firmware driver/user pppoa utils/scripts utils/eagleconnect; do
		make DESTDIR="${D}" -C ${i} install || die "make ${i} install failed"
	done

	doman doc/man/*
	dodoc README ChangeLog

	newinitd "${FILESDIR}/initd" "${PN}"
	newconfd "${FILESDIR}/confd" "${PN}"
	insopts -m 600 ; insinto /etc/ppp/peers ; doins "${FILESDIR}/dsl.peer"
}

pkg_postinst() {
	linux-mod_pkg_postinst

	ewarn "Please set METHOD in /etc/conf.d/${PN} to the needed value:"
	ewarn "dhcpip:"
	ewarn "          Make sure you have dhcpcd emerged."
	ewarn "staticip:"
	ewarn "          Set your static IP in /etc/conf.d/eagle-adsl"
	ewarn "dhcpip && staticip: You can use the following to set up the eagle conf-files:"
	ewarn 'sed -i -e "s/Encapsulation *= *[0-9]\+/Encapsulation=00000004/" /etc/eagle-usb/eagle-usb.conf'
	ewarn 'sed -i -e "s/VCI *= *[0-9]\+/VCI=00000024/" /etc/eagle-usb/eagle-usb.conf'
	ewarn "pppoa:"
	ewarn "          Make sure you have kernel support for HDCL and PPP"
	ewarn "          Edit /etc/ppp/peers/dsl.peer to insert your username as"
	ewarn "          well as /etc/ppp/chap-secrets and /etc/ppp/pap-secrets"
	ewarn
	ewarn "          dsl.peer contains the \"usepeerdns\" option so, you"
	ewarn "          should consider making a symlink named /etc/resolv.conf"
	ewarn "          and pointing to /etc/ppp/resolv.conf:"
	ewarn "rm /etc/resolv.conf"
	ewarn "ln -s /etc/ppp/resolv.conf /etc/resolv.conf"
}
