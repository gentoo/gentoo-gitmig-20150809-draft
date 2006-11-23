# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/em8300-modules/em8300-modules-0.16.0_rc2.ebuild,v 1.3 2006/11/23 20:15:27 zzam Exp $

inherit eutils linux-info

MY_P="${P/_/-}" ; MY_P="${MY_P/-modules/}"

DESCRIPTION="em8300 (RealMagic Hollywood+/Creative DXR3) video decoder card kernel modules"
HOMEPAGE="http://dxr3.sourceforge.net"
SRC_URI="http://dxr3.sourceforge.net/download/${MY_P}.tar.gz"

DEPEND="virtual/linux-sources"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_compile ()  {
	check_KV
	set_arch_to_kernel
	for file in autotools/config.guess configure modules/ldm modules/Makefile modules/INSTALL; do
		sed -i -e 's/uname[[:space:]]*-r/echo ${KV}/' $file
	done
	cd modules
	emake || die "emake failed."
	set_arch_to_portage
}

src_install () {
	insinto "/usr/include/linux"
	doins include/linux/em8300.h

	cd modules

	insinto "/lib/modules/${KV_FULL}/kernel/drivers/video"

	if kernel_is 2 6; then
		doins *.ko
	else
		die "Unsupported kernel."
	fi

	dodoc README-modoptions README-modules.conf

	newsbin devices.sh em8300-devices.sh

	insinto /etc/modules.d
	newins ${FILESDIR}/modules.em8300 em8300

	insinto /etc/udev/rules.d
	newins em8300-udev.rules 15-em8300.rules
}

pkg_postinst () {
	if [ "${ROOT}" = "/" ]
	then
		/sbin/modules-update
	fi

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
