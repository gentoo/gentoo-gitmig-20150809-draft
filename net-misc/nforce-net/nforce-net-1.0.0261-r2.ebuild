# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nforce-net/nforce-net-1.0.0261-r2.ebuild,v 1.6 2004/07/15 03:09:35 agriffis Exp $

inherit gcc kernel-mod eutils

NV_V="${PV/1.0./1.0-}"
NV_PACKAGE="NVIDIA_nforce-${NV_V}"
S="${WORKDIR}/nforce/nvnet"
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
	if kernel-mod_is_2_5_kernel || kernel-mod_is_2_6_kernel
	then
		EPATCH_SINGLE_MSG="Applying 2.5/6 patch ..." \
		epatch ${FILESDIR}/nforce-net-1.0.0261-kernel-2.6.patch.gz
	fi

	make KERNSRC="/usr/src/linux" || die
}

src_install() {
	# The driver goes into the standard modules location
	insinto /lib/modules/${KV}/kernel/drivers/net

	if kernel-mod_is_2_5_kernel || kernel-mod_is_2_6_kernel
	then
		doins nvnet.ko
	else
		doins nvnet.o
	fi

	# Docs
	dodoc ${S}/ReleaseNotes.html

	dodir /etc/modules.d
	cat > ${D}/etc/modules.d/nvnet << EOF
#  The nForce network driver supports two optimization modes:
#   optimization=0 ; Throughput optimization
#   optimization=1 ; CPU optimization
#  CPU optimization mode ruduces the CPU utilization by using
#  interrupt moderation. Throughput optimization mode maximizes
#  the throughput.  This mode has higher CPU consumption.
#  By default, the driver runs in throughput optimization mode.

#  The "speed" module parameter can be used set the interface
#  speed of the ethernet controller.  By default the controller
#  will autosense the interface speed, but also supports the
#  following values:
#     speed=0 ; auto
#     speed=1 ; 10Mbps
#     speed=2 ; 100Mpbs

#  The "duplex" module parameter can be used to specify the
#  interface duplex.  By default the controller will autoselect
#  duplex, but also supports the following values:
#     duplex=0 ; auto
#     duplex=1 ; half duplex
#     duplex=2 ; full duplex

options nvnet optimization="1" speed="0" duplex="0"
EOF
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
	echo
	einfo "Edit /etc/modules.d/nvnet and run \"update-modules\" to configure"
	einfo "the \"nvnet\" driver for throughput optimization the next time it"
	einfo "is loaded."
}
