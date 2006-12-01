# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/em8300-modules/em8300-modules-0.16.0_rc2.ebuild,v 1.4 2006/12/01 20:31:02 zzam Exp $

inherit eutils linux-mod

MY_P="${P/_/-}" ; MY_P="${MY_P/-modules/}"

DESCRIPTION="em8300 (RealMagic Hollywood+/Creative DXR3) video decoder card kernel modules"
HOMEPAGE="http://dxr3.sourceforge.net"
SRC_URI="http://dxr3.sourceforge.net/download/${MY_P}.tar.gz"

DEPEND="virtual/linux-sources"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}/modules"

src_install () {
	insinto "/lib/modules/${KV_FULL}/kernel/drivers/video"

	if kernel_is 2 6; then
		doins *.ko
	else
		die "Unsupported kernel."
	fi

	cd ${S}/..

	insinto "/usr/include/linux"
	doins include/linux/em8300.h

	dodoc README-modoptions README-modules.conf

	newsbin devices.sh em8300-devices.sh

	insinto /etc/modules.d
	newins ${FILESDIR}/modules.em8300 em8300

	insinto /etc/udev/rules.d
	newins em8300-udev.rules 15-em8300.rules
}

pkg_postinst () {
	linux-mod_pkg_postinst

	elog "The em8300 kernel modules have been installed into the modules"
	elog "directory of your currently running kernel.  They haven't been"
	elog "loaded.  Please read the documentation, and if you would like"
	elog "to have the modules load at startup, add em8300, bt865, adv717x"
	elog "to your /etc/modules.autoload.d."
	elog
	elog "You will also need to have the i2c kernel modules compiled for"
	elog "this to be happy, no need to patch any kernel though just turn"
	elog "all the i2c stuff in kernel config to M and you'll be fine."
}
