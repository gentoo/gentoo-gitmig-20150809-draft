# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/nouveau-firmware/nouveau-firmware-20091212.ebuild,v 1.1 2010/02/15 21:26:32 chithanh Exp $

inherit linux-info

DESCRIPTION="firmware for nouveau"
HOMEPAGE="http://nouveau.freedesktop.org/"
SRC_URI="http://people.freedesktop.org/~pq/nouveau-drm/${P}.tar.gz"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT="bindist mirror"

src_install() {
	insinto /lib/firmware
	doins -r nouveau || die "doins failed"
}

pkg_postinst() {
	if linux_config_exists && linux_chkconfig_builtin DRM_NOUVEAU; then
		if ! linux_chkconfig_present FIRMWARE_IN_KERNEL || \
			! [[ "$(linux_chkconfig_string EXTRA_FIRMWARE)" == *nouveau* ]]; then
			ewarn "Your kernel has nouveau DRM built-in but not the CTX microcode."
			ewarn "For kernel modesetting to work, please set in kernel config"
			ewarn "CONFIG_FIRMWARE_IN_KERNEL=y"
			ewarn "CONFIG_EXTRA_FIRMWARE_DIR=\"/lib/firmware\""
			ewarn "CONFIG_EXTRA_FIRMWARE=\"nouveau/xxxx.ctxprog nouveau/yyyy.ctxvals\""
			ewarn "where xxxx and yyyy need to be values corresponding to your hardware."
			ewarn "More information at http://nouveau.freedesktop.org/wiki/InstallDRM"
		fi
	fi
}
