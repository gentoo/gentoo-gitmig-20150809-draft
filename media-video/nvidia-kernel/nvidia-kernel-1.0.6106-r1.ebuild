# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-kernel/nvidia-kernel-1.0.6106-r1.ebuild,v 1.3 2004/11/07 02:01:13 cyfred Exp $

inherit eutils kmod

X86_PKG_V="pkg1"
AMD64_PKG_V="pkg2"
NV_V="${PV/1.0./1.0-}"
X86_NV_PACKAGE="NVIDIA-Linux-x86-${NV_V}"
AMD64_NV_PACKAGE="NVIDIA-Linux-x86_64-${NV_V}"

DESCRIPTION="Linux kernel module for the NVIDIA X11 driver"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="x86? (ftp://download.nvidia.com/XFree86/Linux-x86/${NV_V}/${X86_NV_PACKAGE}-${X86_PKG_V}.run)
	amd64? (http://download.nvidia.com/XFree86/Linux-x86_64/${NV_V}/${AMD64_NV_PACKAGE}-${AMD64_PKG_V}.run)"

if use x86; then
	PKG_V="${X86_PKG_V}"
	NV_PACKAGE="${X86_NV_PACKAGE}"
elif use amd64; then
	PKG_V="${AMD64_PKG_V}"
	NV_PACKAGE="${AMD64_NV_PACKAGE}"
fi

S="${WORKDIR}/${NV_PACKAGE}-${PKG_V}/usr/src/nv"

# The slot needs to be set to $KV to prevent unmerges of modules for other kernels.
LICENSE="NVIDIA"
SLOT="${KV}"
KEYWORDS="-* -x86 -amd64"
RESTRICT="nostrip"
IUSE=""

DEPEND="virtual/linux-sources"
export _POSIX2_VERSION="199209"

KMOD_SOURCES="none"

mtrr_check() {
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

pkg_setup() {
	mtrr_check
}

src_unpack() {
	# Let the kmod eclass set the variables for us
	kmod_src_unpack

	cd ${WORKDIR}
	bash ${DISTDIR}/${NV_PACKAGE}-${PKG_V}.run --extract-only

	# Add patches below, with a breif description.
	# 1) SYSFS supported by nvidia
	# 2) minion.de patches not released yet

	cd ${S}

	# Add koutput compile time support... this is hackish
	epatch ${FILESDIR}/${PV}/NVIDIA_kernel-${NV_V}-koutput-support.patch

	# if you set this then it's your own fault when stuff breaks :)
	[ ! -z "${USE_CRAZY_OPTS}" ] && sed -i "s:-O:${CFLAGS}:" Makefile.*
}

src_compile() {
	# IGNORE_CC_MISMATCH disables a sanity check that's needed when gcc has been
	# updated but the running kernel is still compiled with an older gcc.  This is
	# needed for chrooted building, where the sanity check detects the gcc of the
	# kernel outside the chroot rather than within.
	if is_kernel 2 5 || is_kernel 2 6
	then
		unset ARCH
	fi
	make IGNORE_CC_MISMATCH="yes" SYSSRC="${KERNEL_DIR}" KVOUT="${KV_OUTPUT}"  \
		clean module V=1 || die "Failed to build module"
}

src_install() {
	# The driver goes into the standard modules location
	insinto /lib/modules/${KV}/video

	# Insert the module 
	doins nvidia.${KV_OBJ}

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
		if [ ! -e /dev/.devfsd ] && [ ! -e /dev/.udev ] && [ -x /sbin/NVmakedevices.sh ]
		then
			/sbin/NVmakedevices.sh >/dev/null 2>&1
		fi
	fi

	echo
	einfo "If you need to load the module automatically on boot up you need"
	einfo "to add \"nvidia\" to /etc/modules.autoload.d/kernel-${KV_MAJOR}.${KV_MINOR}"
	echo
	einfo "Please note that the driver name is \"nvidia\", not \"NVdriver\""
	echo
	einfo "This module will now work correctly under udev, you do not need to"
	einfo "manually create the devices anymore."
	echo
}
