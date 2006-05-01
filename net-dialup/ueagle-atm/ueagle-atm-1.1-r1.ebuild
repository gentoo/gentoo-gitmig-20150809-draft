# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ueagle-atm/ueagle-atm-1.1-r1.ebuild,v 1.1 2006/05/01 08:29:37 mrness Exp $

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

	if ! has_version '>=sys-apps/baselayout-1.12.0_pre18' ; then
		ewarn "The best way of using this driver is through the pppd net module of"
		ewarn ">=sys-apps/baselayout-1.12.0_pre18, which is also the only"
		ewarn "documented mode of using ${CATEGORY}/${PN}."
		ewarn "Please install baselayout-1.12.0_pre18 or else you will be on your own!"
		ebeep
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
	CONFIG_CHECK="~FW_LOADER ~NET ~PACKET ~ATM ~NETDEVICES ~USB_DEVICEFS ~USB_ATM ~USB_UEAGLEATM \
		~PPP ~PPPOATM ~PPPOE ~ATM_BR2684"
	check_extra_config
	einfo "Note: All the above kernel configurations are required except the following:"
	einfo "   - CONFIG_PPPOATM is needed only for PPPoA links, while"
	einfo "   - CONFIG_PPPOE and CONFIG_ATM_BR2684 are needed only for PPPoE links."
	echo

	# Check user space for PPPoA support
	if ! built_with_use net-dialup/ppp atm ; then
		eerror "PPPoA support: net-dialup/ppp should be built with 'atm' USE flag enabled!"
		ewarn "Run the following command if you need PPPoA support:"
		einfo "  euse -E atm && emerge net-dialup/ppp"
		echo
	fi
	# Check user space PPPoE support
	if ! has_version net-misc/br2684ctl ; then
		eerror "PPPoE support: net-misc/br2684ctl is not installed!"
		ewarn "Run the following command if you need PPPoE support:"
		einfo "   emerge net-misc/br2684ctl"
		echo
	fi

	ewarn "To complete the installation, you must read the documentation available in"
	ewarn "   ${ROOT}usr/share/doc/${PF}"
}
