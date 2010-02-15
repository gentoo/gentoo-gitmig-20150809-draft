# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/radeon-ucode/radeon-ucode-20091209.ebuild,v 1.1 2010/02/15 17:10:17 chithanh Exp $

inherit linux-info

DESCRIPTION="IRQ microcode for r6xx/r7xx Radeon GPUs"
HOMEPAGE="http://people.freedesktop.org/~agd5f/radeon_ucode/"
SRC_URI="http://people.freedesktop.org/~agd5f/${PN/-/_}/R600_rlc.bin http://people.freedesktop.org/~agd5f/${PN/-/_}/R700_rlc.bin"

LICENSE="radeon-ucode"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	insinto /lib/firmware/radeon || die "insinto failed"
	doins "${DISTDIR}"/R{6,7}00_rlc.bin || die "doins failed"
}

pkg_postinst() {
	if linux_config_exists && linux_chkconfig_builtin DRM_RADEON; then
		if ! linux_chkconfig_present FIRMWARE_IN_KERNEL || \
			! [[ "$(linux_chkconfig_string EXTRA_FIRMWARE)" == *R?00_rlc.bin* ]]; then
			ewarn "Your kernel has radeon DRM built-in but not the IRQ microcode."
			ewarn "For kernel modesetting to work, please set in kernel config"
			ewarn "CONFIG_FIRMWARE_IN_KERNEL=y"
			ewarn "CONFIG_EXTRA_FIRMWARE_DIR=\"/lib/firmware\""
			ewarn "CONFIG_EXTRA_FIRMWARE=\"radeon/R600_rlc.bin radeon/R700_rlc.bin\""
			ewarn "More information at http://wiki.x.org/wiki/radeonBuildHowTo"
		fi
	fi
}
