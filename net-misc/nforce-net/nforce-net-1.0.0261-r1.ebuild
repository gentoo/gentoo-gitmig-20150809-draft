# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nforce-net/nforce-net-1.0.0261-r1.ebuild,v 1.2 2003/06/13 00:12:28 alron Exp $

inherit gcc

# Make sure Portage does _NOT_ strip symbols.  Need both lines for
# Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"

NV_V="${PV/1.0./1.0-}"
NV_PACKAGE="NVIDIA_nforce-${NV_V}"
S="${WORKDIR}/nforce"
DESCRIPTION="Linux kernel module for the NVIDIA's nForce network chip"
SRC_URI="http://download.nvidia.com/XFree86/nforce/${NV_V}/${NV_PACKAGE}.tar.gz"
HOMEPAGE="http://www.nvidia.com/"

# The slow needs to be set to $KV to prevent unmerges of
# modules for other kernels.
LICENSE="NVIDIA"
SLOT="${KV}"
KEYWORDS="-* x86"

DEPEND="virtual/linux-sources >=sys-apps/portage-1.9.10"

src_compile() {
	# Portage should determine the version of the kernel sources
	check_KV
	cd ${S}/nvnet
	make KERNSRC="/usr/src/linux" || die
}

src_install() {
	# The driver goes into the standard modules location
	insinto /lib/modules/${KV}/kernel/drivers/net
	doins nvnet/nvnet.o
    
	# Docs
	dohtml ${S}/ReleaseNotes.html

	dodir /etc/modules.d
	cat > ${D}/etc/modules.d/nvnet << EOF
#  The nForce network driver supports two optimization modes:
#   optimization=1 ; CPU optimization
#   optimization=2 ; Throughput optimization
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

options nvnet optimization="1"  speed="0" duplex="0"
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
	einfo "Edit /etc/modules.d/nvnet and run \"update-mmodules\" to configure"
	einfo "the \"nvnet\" driver for throughput optimization the next time it"
	einfo "is loaded."
}

