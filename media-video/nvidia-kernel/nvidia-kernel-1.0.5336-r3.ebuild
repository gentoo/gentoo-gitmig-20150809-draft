# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-kernel/nvidia-kernel-1.0.5336-r3.ebuild,v 1.5 2004/07/26 20:32:24 spyderous Exp $

inherit eutils kmod

PKG_V="pkg1"
NV_V="${PV/1.0./1.0-}"
NV_PACKAGE="NVIDIA-Linux-x86-${NV_V}"
S="${WORKDIR}/${NV_PACKAGE}-${PKG_V}/usr/src/nv"
DESCRIPTION="Linux kernel module for the NVIDIA's X driver"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="ftp://download.nvidia.com/XFree86/Linux-x86/${NV_V}/${NV_PACKAGE}-${PKG_V}.run"
IUSE=""

# The slot needs to be set to $KV to prevent unmerges of modules for other kernels.
LICENSE="NVIDIA"
SLOT="${KV}"
KEYWORDS="-* ~x86"
RESTRICT="nostrip"

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

	echo
	ewarn "The new 2.6.6 Series kernels include an option for 4K Stack sizes,"
	ewarn "this option must NOT be selected. This driver will only work with"
	ewarn "the OLD 8K Stack size, please ensure you leave 8K stack sizes for now."
	echo
}

ck_kern_write() {
	if [ ! "${KV_PATCH}" -ge "6" ]
	then
		ewarn "You are running Linux Kernel ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}\n"
		ewarn "Due to incompatibilities between the current nvidia drivers and"
		ewarn "the new 2.6.6 kernel sources we need to use the koutput feature"
		ewarn "unfortunately this means that older kernels will be omitted from"
		ewarn "the sandbox for this build.\n"
		ewarn "This will be over come with newer driver releases from nvidia."
		echo
		ewarn "THIS BUILD WILL NOT WORK WITH FEATURES=\"userpriv\""
		echo
		ewarn "We are working to resolve this issue, please disable userpriv"
		ewarn "if you use it while building nvidia-kernel."
		return 0
	else
		return 1
	fi
}

src_unpack() {
	# Let the kmod eclass set the variables for us
	kmod_src_unpack

	cd ${WORKDIR}
	bash ${DISTDIR}/${NV_PACKAGE}-${PKG_V}.run --extract-only

	# Next section applies patches for linux-2.5 kernel, and/or
	# bugfixes for linux-2.4.  All these are from:
	#
	#   http://www.minion.de/nvidia/
	#
	# Many thanks to Christian Zander <zander@minion.de> for bringing
	# these to us, and being so helpful to select which to use.

	cd ${S}

	if is_kernel 2 5 || is_kernel 2 6
	then
		EPATCH_SINGLE_MSG="Applying basic sysfs patch ..." \
		epatch ${FILESDIR}/${PV}/NVIDIA_kernel-${NV_V}-basic-sysfs-support.patch

		# The 2.6 kernels support a form of kbuild now we will aswell.
		rm makefile
		ln -snf Makefile.kbuild Makefile

	fi

	# if you set this then it's your own fault when stuff breaks :)
	[ ! -z "${USE_CRAZY_OPTS}" ] && sed -i "s:-O:${CFLAGS}:" Makefile
}

src_compile() {
	# IGNORE_CC_MISMATCH disables a sanity check that's needed when gcc has been
	# updated but the running kernel is still compiled with an older gcc.  This is
	# needed for chrooted building, where the sanity check detects the gcc of the
	# kernel outside the chroot rather than within.
	if is_kernel 2 5 || is_kernel 2 6
	then
		if ck_kern_write
		then
			KD="`/bin/readlink -f ${KERNEL_DIR}`"
			einfo "Adding write support to ${KD}\n"
			addwrite "${KD}"
		fi

		unset ARCH
		make IGNORE_CC_MISMATCH="yes" SYSSRC="${KERNEL_DIR}" \
			M="${S}" clean module || die "Failed to build module"
	else
		make IGNORE_CC_MISMATCH="yes" KERNDIR="${ROOT}/usr/src/linux" \
			clean module || die
	fi
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
	einfo "Please note that the driver name is nvidia.${KV_OBJ}, not NVdriver"
	echo
}
