# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-kernel/nvidia-kernel-1.0.6111-r3.ebuild,v 1.1 2004/11/07 01:52:46 cyfred Exp $

inherit eutils kernel-mod

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
KEYWORDS="-* x86 amd64"
RESTRICT="nostrip"
IUSE=""

DEPEND="virtual/linux-sources"
export _POSIX2_VERSION="199209"

KMOD_SOURCES="none"

# Check for mtrr and react appropriately
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
	# setup the environment
	kernel-mod_getversion
	if [ ${KV_MINOR} -ge 5 ]
	then
		KV_OBJ="ko"
	else
		KV_OBJ="o"
	fi

	# 2.6.10_rc1-mm{1,2,3} all EXPORT_SYMBOL_GPL the udev functions, this breaks loading
	CS="$(grep -c EXPORT_SYMBOL\(class_simple_create\)\; ${KERNEL_DIR}/drivers/base/class_simple.c)"
	if [ "${CS}" == "0" ]
	then
		ewarn "Your current kernel uses EXPORT_SYMBOL_GPL() on some methods required by nvidia-kernel"
		ewarn "This probably means 2.6.10_rc1-mm*, please change away from mm-sources until this is"
		ewarn "revised and a solution released in the mm branch, development-sources will work."
		die "Incompatible kernel export."
	fi

	# Right, we are officially not supporting < 2.6.7 in the 2.6 kernel tree
	# In fact as this warning states its highly likely you CANNOT use those kernels
	if [ ${KV_MINOR} -ge 6 -a ${KV_PATCH} -lt 7 ]
	then
		echo
		ewarn "Your kernel version is ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}"
		ewarn "This is not officially supported for ${P}. It is likely you"
		ewarn "will not be able to compile or use the kernel module."
		ewarn "It is recommended that you upgrade your kernel to a version >= 2.6.7"
		echo
		ewarn "DO NOT file bug reports for kernel versions less than 2.6.7 as they will be ignored."
	fi

	cd ${WORKDIR}
	bash ${DISTDIR}/${NV_PACKAGE}-${PKG_V}.run --extract-only

	# Add patches below, with a breif description.
	# 1) SYSFS supported by nvidia
	# 2) minion.de patches not released yet

	cd ${S}

	# Fix up the removal of PM_SAVE_STATE in kernels > 2.6.8
	epatch ${FILESDIR}/${PV}/power-suspend-2.6.9-changes.patch
	# Update pci stuff to work with irqroutes being changed in kernels
	epatch ${FILESDIR}/${PV}/nv_enable_pci.patch
	# Fix VMALLOC_RESERVE issues with the new 2.6.9 release candidates
	epatch ${FILESDIR}/${PV}/vmalloc-reserve.patch
	# Port pci_find_class() -> pci_get_class() for >= 2.6.9-rc2
	epatch ${FILESDIR}/${PV}/nv-pci_find_class.patch
	# Fix remap_page_range() -> remap_pfn_range() for >= 2.6.9-rc2
	epatch ${FILESDIR}/${PV}/nv-remap-range.patch
	# Fix the /usr/src/linux/include/asm not existing on koutput issue #58294
	epatch ${FILESDIR}/${PV}/conftest_koutput_includes.patch

	# if you set this then it's your own fault when stuff breaks :)
	[ ! -z "${USE_CRAZY_OPTS}" ] && sed -i "s:-O:${CFLAGS}:" Makefile.*
}

src_compile() {
	# Right as kmod was deprecated there is little room for kbuild but lets 
	# at least have some sembalance of support for those who are forcing
	# a non-standard build directory.
	if [ ${KV_MINOR} -ge 6 -a ${KV_PATCH} -ge 7 ]
	then
		# Is this really needed?
		unset ARCH

		if [ -n "${KBUILD_OUTPUT_PREFIX}" ]
		then
			einfo "Determining kernel output location"
			OUTPUT="${KBUILD_OUTPUT_PREFIX}/${KV_VERSION_FULL}"
		fi
	fi
	[ -z "${OUTPUT}" ] && OUTPUT=${KERNEL_DIR}
	einfo "Using ${OUTPUT} as kernel output location"
	echo
	# Now its possible that we might be here without using a KBUILD kernel
	# (ie the variable is set, but using non-kbuild kernel or different path)
	if [ ! -d ${OUTPUT} ]
	then
		ewarn "Your system global KBUILD_OUTPUT is set to ${KBUILD_OUTPUT_PREFIX}"
		ewarn "However your kernels output path ${OUTPUT} does not exist."
		echo
		ewarn "Using ${KERNEL_DIR} as your kernel output location."
		echo
		OUTPUT=${KERNEL_DIR}
	fi

	# IGNORE_CC_MISMATCH disables a sanity check that's needed when gcc has been
	# updated but the running kernel is still compiled with an older gcc.  This is
	# needed for chrooted building, where the sanity check detects the gcc of the
	# kernel outside the chroot rather than within.
	make IGNORE_CC_MISMATCH="yes" SYSSRC="${KERNEL_DIR}" SYSOUT="${OUTPUT}"  \
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
