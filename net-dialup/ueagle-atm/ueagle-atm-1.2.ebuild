# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ueagle-atm/ueagle-atm-1.2.ebuild,v 1.1 2006/09/23 16:25:11 mrness Exp $

inherit eutils linux-info

DESCRIPTION="Firmware and configuration instructions for ADI 930/Eagle USB ADSL Modem driver"
HOMEPAGE="https://gna.org/projects/ueagleatm/"
SRC_URI="http://eagle-usb.org/ueagle-atm/non-free/ueagle-data-src-${PV}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-dialup/ppp-2.4.3-r14
	!net-dialup/eagle-usb"

S="${WORKDIR}/ueagle-data-src-${PV}"

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is lt 2 6 16 ; then
		eerror "The kernel-space driver exists only in kernels >= 2.6.16."
		eerror "Please emerge net-dialup/eagle-usb instead or upgrade the kernel."
		die "Unsupported kernel version"
	fi
}

src_compile() {
	make generate
}

src_install() {
	# Copy to the firmware directory
	insinto /lib/firmware/ueagle-atm
	doins build/* || die "doins firmware failed"

	# Documentation necessary to complete the setup
	dodoc "${FILESDIR}/README" || die "dodoc failed"
}

pkg_postinst() {
	# Check kernel configuration
	local CONFIG_CHECK="~FW_LOADER ~NET ~PACKET ~ATM ~NETDEVICES ~USB_DEVICEFS ~USB_ATM ~USB_UEAGLEATM \
		~PPP ~PPPOATM ~PPPOE ~ATM_BR2684"
	local WARNING_PPPOATM="CONFIG_PPPOATM:\t is not set (required for PPPoA links)"
	local WARNING_PPPOE="CONFIG_PPPOE:\t is not set (required for PPPoE links)"
	local WARNING_ATM_BR2684="CONFIG_ATM_BR2684:\t is not set (required for PPPoE links)"
	check_extra_config
	echo

	# Check user-space for PPPoA support
	if ! built_with_use net-dialup/ppp atm ; then
		ewarn "Run the following command if connecting via PPPoA protocol:"
		ewarn "   euse -E atm && emerge net-dialup/ppp"
		echo
	fi
	# Check user-space for PPPoE support
	if ! has_version net-misc/br2684ctl ; then
		ewarn "Run the following command if connecting via PPPoE protocol:"
		ewarn "   emerge net-misc/br2684ctl"
		echo
	fi

	ewarn "To complete the installation, you must read the documentation in"
	ewarn "   ${ROOT}usr/share/doc/${PF}"
}
