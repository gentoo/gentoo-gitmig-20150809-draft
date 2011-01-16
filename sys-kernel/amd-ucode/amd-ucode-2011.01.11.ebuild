# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/amd-ucode/amd-ucode-2011.01.11.ebuild,v 1.1 2011/01/16 23:48:36 flameeyes Exp $

inherit versionator linux-info

MY_P="${PN}-$(replace_all_version_separators -)"

DESCRIPTION="AMD Family 10h, 11h and 14h microcode patch data"
HOMEPAGE="http://www.amd64.org/support/microcode.html"
SRC_URI="http://www.amd64.org/pub/microcode/${MY_P}.tar"

LICENSE="amd-ucode"
SLOT="0"
IUSE=""

# only meaningful for x86 and x86-64
KEYWORDS="-* ~amd64 ~x86"

# The license does not allow us to mirror the content.
RESTRICT="mirror"

S="${WORKDIR}/${MY_P}"

CONFIG_CHECK="~MICROCODE_AMD"
ERROR_MICROCODE_AMD="Your kernel needs to support AMD microcode loading. You're suggested to build it as a module as it doesn't require a reboot to reload the microcode, that way."

src_install() {
	insinto /lib/firmware/amd-ucode
	doins microcode_amd.bin || die

	# INSTALL file also has instructions to load it, so install it as
	# part of the documentation.
	dodoc README INSTALL || die
}

pkg_postinst() {
	elog "The microcode will be updated next time the microcode kernel code"
	elog "will be executed; you can issue the following command to force a"
	elog "reload, if you built the support as modules:"
	elog ""
	elog "    modprobe -r microcode && modprobe microcode"
	elog ""
	elog "If you didn't build the microcode support as a module, you should"
	elog "rebuild your kernel with the new microcode embedded."

	if linux_config_exists && ! linux_chkconfig_module MICROCODE; then
		ewarn ""
		ewarn "You're suggested to build CPU microcode update support as module"
		ewarn "as there is currently no automatic way to load in the updated"
		ewarn "microcode when it is built-in in the kernel."
		ewarn ""
	fi
}
