# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-kernel/nvidia-kernel-1.0.4349-r1.ebuild,v 1.2 2003/04/21 15:49:44 pfeifer Exp $

inherit eutils

# Make sure Portage does _NOT_ strip symbols.  Need both lines for
# Portage 1.8.9+
DEBUGBUILD="yes"
RESTRICT="nostrip"

NV_V="${PV/1.0./1.0-}"
NV_PACKAGE="NVIDIA_kernel-${NV_V}"
S="${WORKDIR}/${NV_PACKAGE}"
DESCRIPTION="Linux kernel module for the NVIDIA's X driver"
SRC_URI="ftp://download.nvidia.com/XFree86/Linux-x86/${NV_V}/${NV_PACKAGE}.tar.gz"
HOMEPAGE="http://www.nvidia.com/"

# The slow needs to be set to $KV to prevent unmerges of
# modules for other kernels.
LICENSE="NVIDIA"
SLOT="${KV}"
KEYWORDS="x86 -ppc -sparc -alpha -hppa -mips -arm"

DEPEND="virtual/linux-sources
	>=sys-apps/portage-1.9.10"
RDEPEND=${DEPEND}
IUSE=""

pkg_setup() {
	if [ ! -f /proc/mtrr ]
	then
		eerror "This version needs MTRR support for most chipsets!"
		eerror "Please enable MTRR support in your kernel config, found at:"
		eerror
		eerror "  Processor type and features -> [*] MTRR (Memory Type Range Register) support"
		eerror
		eerror "and recompile your kernel ..."
		die "MTRR support not detected!"
	fi
}

src_unpack() {
	unpack ${A}

	# Next section applies patches for linux-2.5 kernel, or if
	# linux-2.4, the page_alloc.c patch courtesy of NVIDIA Corporation.
	# All these are from:
	#
	#   http://www.minion.de/nvidia/
	#
	# Many thanks to Christian Zander <zander@minion.de> for bringing
	# these to us, and being so helpful to select which to use.
	# The patches should close bugs #9704 & #15722.

	local KV_major="`uname -r | cut -d. -f1`"
	local KV_minor="`uname -r | cut -d. -f2`"
	local KV_micro="`uname -r | cut -d. -f3 | sed -e 's:[^0-9].*::'`"

	cd ${S}
	einfo "Linux kernel ${KV_major}.${KV_minor}.${KV_micro}"
	if [ "${KV_major}" -eq 2 -a "${KV_minor}" -eq 5 ]
	then
		EPATCH_SINGLE_MSG="Applying tasklet patch for kernel 2.5..." \
		epatch ${FILESDIR}/${PV}/${NV_PACKAGE}-2.5-20030401.diff

		# Some problems with kbuild one ..
		ln -s Makefile.nvidia Makefile
	fi

#	if [ "${KV_major}" -eq 2 -a "${KV_minor}" -eq 4 ] && \
#	   [ -r /usr/src/linux/mm/rmap.c ]
#	then
#		einfo "Detected rmap enabled kernel."
#		EPATCH_SINGLE_MSG="Applying rmap patch for kernel 2.4..." \
#		epatch ${FILESDIR}/${NV_PACKAGE}-2.5-tl.diff
#
#	elif [ "${KV_major}" -eq 2 -a "${KV_minor}" -eq 5 ]
#	then
#		EPATCH_SINGLE_MSG="Applying tasklet patch for kernel 2.5..." \
#		epatch ${FILESDIR}/${NV_PACKAGE}-2.5-tl.diff
#
#		if [ "${KV_micro}" -ge 54 ]
#		then
#			EPATCH_SINGLE_MSG="Applying module_loader_no_common_sections patch..." \
#			epatch ${FILESDIR}/${NV_PACKAGE}-2.5.54.diff
#		fi
#		if [ "${KV_micro}" -ge 63 ]
#		then
#			EPATCH_SINGLE_MSG="Applying missing_modversion.h patch..." \
#			epatch ${FILESDIR}/${NV_PACKAGE}-2.5.63.diff
#		fi
#	fi
}

src_compile() {
	# Portage should determine the version of the kernel sources
	check_KV
	# IGNORE_CC_MISMATCH disables a sanity check that's needed when gcc has been
	# updated but the running kernel is still compiled with an older gcc.  This is
	# needed for chrooted building, where the sanity check detects the gcc of the
	# kernel outside the chroot rather than within.
	make IGNORE_CC_MISMATCH="yes" KERNDIR="/usr/src/linux" \
		clean nvidia.o || die
}

src_install() {
	# The driver goes into the standard modules location
	insinto /lib/modules/${KV}/video
	doins nvidia.o

	# Add the aliases
	insinto /etc/modules.d
	newins ${FILESDIR}/nvidia-1.1 nvidia

	# Docs
	dodoc ${S}/README

	# The device creation script
	into /
	newsbin ${S}/makedevices.sh NVmakedevices.sh
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		# Update module dependency
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
		if [ ! -e /dev/.devfsd ] && [ -x /sbin/NVmakedevices.sh ]
		then
			/sbin/NVmakedevices.sh >/dev/null 2>&1
		fi
	fi

	echo
	einfo "If you are not using devfs, loading the module automatically at"
	einfo "boot up, you need to add \"nvidia\" to your /etc/modules.autoload."
	echo
	ewarn "Please note that the driver name changed from \"NVdriver\""
	ewarn "to \"nvidia.o\"."
	echo
}

