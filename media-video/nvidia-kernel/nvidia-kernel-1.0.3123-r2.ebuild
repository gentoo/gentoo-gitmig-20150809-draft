# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-kernel/nvidia-kernel-1.0.3123-r2.ebuild,v 1.9 2004/01/29 09:55:36 vapier Exp $

inherit eutils

NV_V="${PV/1.0./1.0-}"
NV_PACKAGE="NVIDIA_kernel-${NV_V}"
S="${WORKDIR}/${NV_PACKAGE}"
DESCRIPTION="Linux kernel module for the NVIDIA's X driver"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="http://download.nvidia.com/XFree86_40/${NV_V}/${NV_PACKAGE}.tar.gz"

# The slot needs to be set to $KV to prevent unmerges of modules for other kernels.
LICENSE="NVIDIA"
SLOT="${KV}"
KEYWORDS="-* x86"
RESTRICT="nostrip"

DEPEND="virtual/linux-sources"
export _POSIX2_VERSION="199209"

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
	# This should close bug #9704.

	local KV_major="`uname -r | cut -d. -f1`"
	local KV_minor="`uname -r | cut -d. -f2`"
	local KV_micro="`uname -r | cut -d. -f3 | sed -e 's:[^0-9].*::'`"

	cd ${S}
	if [ "${KV_major}" -eq 2 -a "${KV_minor}" -eq 5 ]
	then
		EPATCH_SINGLE_MSG="Applying tasklet patch for kernel 2.5..." \
		epatch ${FILESDIR}/${NV_PACKAGE}-2.5-tl.diff
		EPATCH_SINGLE_MSG="Applying page_alloc.c patch..." \
		epatch ${FILESDIR}/${NV_PACKAGE}-2.5-tl-pa.diff
		EPATCH_SINGLE_MSG="Applying module patch for 2.5..." \
		epatch ${FILESDIR}/${NV_PACKAGE}-2.5-module.diff

		if [ "${KV_micro}" -gt 53 ]
		then
			EPATCH_SINGLE_MSG="Applying module patch for 2.5.54 or later..." \
			epatch ${FILESDIR}/${NV_PACKAGE}-2.5.54.diff
		fi
	else
		EPATCH_SINGLE_MSG="Applying page_alloc.c patch..." \
		epatch ${FILESDIR}/${NV_PACKAGE}-pa.diff
	fi
}

src_compile() {
	# Portage should determine the version of the kernel sources
	check_KV
	#IGNORE_CC_MISMATCH disables a sanity check that's needed when gcc has been
	#updated but the running kernel is still compiled with an older gcc.  This is
	#needed for chrooted building, where the sanity check detects the gcc of the
	#kernel outside the chroot rather than within.
	make IGNORE_CC_MISMATCH="yes" KERNDIR="/usr/src/linux" \
		clean NVdriver || die
}

src_install() {
	# The driver goes into the standard modules location
	insinto /lib/modules/${KV}/video
	doins NVdriver

	# Add the aliases
	insinto /etc/modules.d
	doins ${FILESDIR}/nvidia

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

	einfo "If you are not using devfs, loading the module automatically at"
	einfo "boot up, you need to add \"NVdriver\" to your /etc/modules.autoload."
	einfo
}
