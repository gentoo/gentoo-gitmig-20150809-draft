# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nforce-net/nforce-net-1.0.0256.ebuild,v 1.10 2004/07/15 03:09:35 agriffis Exp $

inherit gcc

NV_V="${PV/1.0./1.0-}"
NV_PACKAGE="NVIDIA_nforce-${NV_V}"
S="${WORKDIR}/nforce"
DESCRIPTION="Linux kernel module for the NVIDIA's nForce network chip"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="http://download.nvidia.com/XFree86/nforce/${NV_V}/${NV_PACKAGE}.tar.gz"

# The SLOT needs to be set to $KV to prevent unmerges of modules for other kernels
LICENSE="NVIDIA"
SLOT="${KV}"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="nostrip"

DEPEND="virtual/linux-sources"

src_compile() {
	check_KV
	cd ${S}/nvnet
	make KERNSRC="/usr/src/linux" || die
}

src_install() {
	# The driver goes into the standard modules location
	insinto /lib/modules/${KV}/kernel/drivers/net
	doins nvnet/nvnet.o

	# Docs
	dodoc ${S}/ReleaseNotes.html
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		# Update module dependency
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
	fi

	echo
	einfo "You need to add \"nvnet\" to your /etc/modules.autoload to load"
	einfo "this module when the system is started. Alternatively, you can"
	einfo "use the 'hotplug' package ('emerge hotplug' then 'rc-update add"
	einfo "hotplug default') to auto-detect and load \"nvnet\" on startup."
}
