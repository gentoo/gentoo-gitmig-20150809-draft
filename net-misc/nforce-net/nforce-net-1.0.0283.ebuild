# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nforce-net/nforce-net-1.0.0283.ebuild,v 1.1 2004/09/25 15:41:32 lanius Exp $

inherit gcc kmod eutils

PKG_V="pkg1"
NV_V="${PV/1.0./1.0-}"
X86_NV_PACKAGE="NFORCE-Linux-x86-${NV_V}"
AMD64_NV_PACKAGE="NFORCE-Linux-x86_64-${NV_V}"

DESCRIPTION="Linux kernel module for the NVIDIA's nForce network chip"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="x86? (http://download.nvidia.com/XFree86/nforce/${NV_V}/${X86_NV_PACKAGE}-${PKG_V}.run)
	amd64? (http://download.nvidia.com/XFree86/nforce/amd64/${NV_V}/${AMD64_NV_PACKAGE}-${PKG_V}.run)"

if use x86; then
	NV_PACKAGE="${X86_NV_PACKAGE}"
elif use amd64; then
	NV_PACKAGE="${AMD64_NV_PACKAGE}"
fi

S="${WORKDIR}/${NV_PACKAGE}-${PKG_V}/nvnet"

# The SLOT needs to be set to $KV to prevent unmerges of modules for other kernels
LICENSE="NVIDIA"
SLOT="${KV}"
KEYWORDS="-* ~x86 ~amd64"
RESTRICT="nostrip"
IUSE=""

DEPEND="virtual/linux-sources"

KMOD_SOURCES="none"

src_unpack() {
	# Let the kmod eclass set the variables for us
	kmod_src_unpack

	cd ${WORKDIR}
	bash ${DISTDIR}/${NV_PACKAGE}-${PKG_V}.run --extract-only

	cd ${S}
	if is_kernel 2 5 || is_kernel 2 6
	then
		# The 2.6 kernels support a form of kbuild now we will aswell.
		rm makefile
		ln -snf Makefile.kbuild Makefile
	fi
}

src_compile() {
	check_KV
	env -u ARCH make SYSSRC="${KERNEL_DIR}" clean module || die
}

src_install() {
	# The driver goes into the standard modules location
	insinto /lib/modules/${KV}/kernel/drivers/net
	doins nvnet.${KV_OBJ}

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

#  The "force_speed_duplex" module parameter can be used set the
#  interface speed and duplex of the ethernet controller.  The
#  following values are supported:
#   force_speed_duplex=0 - autonegotiate
#   force_speed_duplex=1 - 10Mbps half duplex
#   force_speed_duplex=2 - 10Mbps full duplex
#   force_speed_duplex=3 - 100Mbps half duplex
#   force_speed_duplex=4 - 100Mbps full duplex
#   force_speed_duplex=5 - autonegotiate for 10Mbps half duplex
#   force_speed_duplex=6 - autonegotiate for 10Mbps full duplex
#   force_speed_duplex=7 - autonegotiate for 100Mbps half duplex
#   force_speed_duplex=8 - autonegotiate for 100Mbps full duplex
#   force_speed_duplex=9 - autonegotiate for 1000Mbps full duplex

options nvnet optimization="1" force_speed_duplex="0"
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
	echo
	einfo "An open-source network driver (\"forcedeth\") is now included in"
	einfo "both the 2.4 and 2.6 kernels. It is recommended that you use"
	einfo "forcedeth as opposed to this driver, as nvidia appear to be"
	einfo "supporting it now."
}
