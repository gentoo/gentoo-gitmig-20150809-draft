# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-kernel/nvidia-kernel-1.0.8756.ebuild,v 1.2 2006/05/02 14:14:55 augustus Exp $

inherit eutils linux-mod

X86_PKG_V="pkg1"
AMD64_PKG_V="pkg2"
NV_V="${PV/1.0./1.0-}"
X86_NV_PACKAGE="NVIDIA-Linux-x86-${NV_V}"
AMD64_NV_PACKAGE="NVIDIA-Linux-x86_64-${NV_V}"

DESCRIPTION="Linux kernel module for the NVIDIA X11 driver"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="x86? ( ftp://download.nvidia.com/XFree86/Linux-x86/${NV_V}/${X86_NV_PACKAGE}-${X86_PKG_V}.run )
	amd64? ( http://download.nvidia.com/XFree86/Linux-x86_64/${NV_V}/${AMD64_NV_PACKAGE}-${AMD64_PKG_V}.run )"

if use x86; then
	PKG_V="${X86_PKG_V}"
	NV_PACKAGE="${X86_NV_PACKAGE}"
elif use amd64; then
	PKG_V="${AMD64_PKG_V}"
	NV_PACKAGE="${AMD64_NV_PACKAGE}"
fi

S="${WORKDIR}/${NV_PACKAGE}-${PKG_V}/usr/src/nv"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="-* amd64 ~x86"
RESTRICT="nostrip"
IUSE=""

RDEPEND="virtual/modutils"
DEPEND="virtual/linux-sources"
export _POSIX2_VERSION="199209"

mtrr_check() {
	ebegin "Checking for MTRR support"
	linux_chkconfig_present MTRR
	eend $?

	if [[ $? -ne 0 ]] ; then
		eerror "This version needs MTRR support for most chipsets!"
		eerror "Please enable MTRR support in your kernel config, found at:"
		eerror
		eerror "  Processor type and features"
		eerror "    [*] MTRR (Memory Type Range Register) support"
		eerror
		eerror "and recompile your kernel ..."
		die "MTRR support not detected!"
	fi
}

pkg_setup() {
	linux-mod_pkg_setup
	MODULE_NAMES="nvidia(video:${S})"
	BUILD_PARAMS="IGNORE_CC_MISMATCH=yes V=1 SYSSRC=${KV_DIR} SYSOUT=${KV_OUT_DIR}"
	mtrr_check
}

src_unpack() {
	local NV_PATCH_PREFIX="${FILESDIR}/${PV}/NVIDIA_kernel-1.0-${PV##*.}"

	if [[ ${KV_MINOR} -eq 6 && ${KV_PATCH} -lt 7 ]] ; then
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
	cd ${S}
	# Any general patches should go here

	# Patches from Zander goes here

	# Now any patches specific to the 2.6 kernel should go here
	#if kernel_is 2 6 ; then
	#	einfo "Applying 2.6 kernel patches"
	#fi

	# Quiet down warnings the user do not need to see
	sed -i \
		-e 's:-Wpointer-arith::g' \
		-e 's:-Wsign-compare::g' \
		${S}/Makefile.kbuild

	# If you set this then it's your own fault when stuff breaks :)
	[[ -n ${USE_CRAZY_OPTS} ]] && sed -i "s:-O:${CFLAGS}:" Makefile.*

	# If greater than 2.6.5 use M= instead of SUBDIR=
	cd ${S}; convert_to_m Makefile.kbuild
}

src_install() {
	linux-mod_src_install

	# Add the aliases
	sed -e 's:\${PACKAGE}:'${PF}':g' ${FILESDIR}/nvidia > ${WORKDIR}/nvidia
	insinto /etc/modules.d
	newins ${WORKDIR}/nvidia nvidia

	# Docs
	# Bug #97768: Install README correctly and install Changelog.
	newdoc ${S}/../../share/doc/README.txt README
	dodoc ${S}/../../share/doc/NVIDIA_Changelog
	dodoc ${S}/../../share/doc/Copyrights
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
