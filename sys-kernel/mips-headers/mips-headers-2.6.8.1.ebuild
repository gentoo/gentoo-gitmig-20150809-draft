# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-headers/mips-headers-2.6.8.1.ebuild,v 1.4 2005/02/06 04:48:42 kumba Exp $


# Eclass stuff
ETYPE="headers"
inherit kernel eutils

# Version Data
OKV=${PV/_/-}
CVSDATE="20040822"			# Date of diff between kernel.org and lmo CVS
COBALTPATCHVER="1.7"			# Tarball version for cobalt patches
GENPATCHVER="1.0"			# Tarball version for generic patches
EXTRAVERSION=-mipscvs-${CVSDATE}
KV="${OKV}${EXTRAVERSION}"

# Miscellaneous stuff
S=${WORKDIR}/linux-${KV}

# What's in this kernel?

# INCLUDED:
# 1) linux sources from kernel.org
# 2) linux-mips.org CVS snapshot diff from 04 Jun 2004
# 3) Cobalt Patches
# 4) Generic mips patches

DESCRIPTION="Linux Headers from Linux-Mips CVS, dated ${CVSDATE}"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
		mirror://gentoo/mipscvs-${OKV}-${CVSDATE}.diff.bz2
		mirror://gentoo/mips-sources-generic_patches-${GENPATCHVER}.tar.bz2
		cobalt? ( mirror://gentoo/cobalt-patches-26xx-${COBALTPATCHVER}.tar.bz2 )"

HOMEPAGE="http://www.linux-mips.org/"
LICENSE="GPL-2"
SLOT="0"
PROVIDE="virtual/os-headers"
KEYWORDS="-* ~mips"
IUSE="cobalt"

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/linux-${OKV} ${S}
	cd ${S}

	# We need these patches from linux26-headers, and they're pretty big, so avoid re-adding them to the tree
	cp ${PORTDIR}/sys-kernel/linux26-headers/files/linux26-headers-2.6.8.1-appCompat.patch ${WORKDIR}
	cp ${PORTDIR}/sys-kernel/linux26-headers/files/linux26-headers-2.6.8.1-strict-ansi-fix.patch ${WORKDIR}

	# Update the vanilla sources with linux-mips CVS changes
	epatch ${WORKDIR}/mipscvs-${OKV}-${CVSDATE}.diff

	# Cobalt Patches
	if use cobalt; then
		echo -e ""
		einfo ">>> Patching kernel for Cobalt support ..."
		for x in ${WORKDIR}/cobalt-patches-26xx-${COBALTPATCHVER}/*.patch; do
			epatch ${x}
		done
	fi

	# User-space patches for various things
	epatch ${FILESDIR}/${PN}-2.6.0-sysctl_h-compat.patch
	epatch ${FILESDIR}/${PN}-2.6.0-fb.patch
	epatch ${WORKDIR}/linux26-headers-2.6.8.1-appCompat.patch
	epatch ${WORKDIR}/linux26-headers-2.6.8.1-strict-ansi-fix.patch

	# Generic patches we always include
	echo -e ""
	einfo ">>> Generic Patches"
		# IP22 patches
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.8-ip22-fixes-backport.patch
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.8-ip22-newport-fixes-backport.patch

		# IP32 Patches
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.8-ip32-64b_only-backport.patch
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.9-ip32-iluxa_minpatchset_bits.patch
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.7-maceisa_rtc_irq-fix.patch

		# Generic
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.8-better_mbind-backport.patch
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.8-elim-sys_narg_table-backport.patch
		epatch ${WORKDIR}/mips-patches/mipscvs-2.6.8-statfs-fixes-backport.patch
	eend

	# Do Stuff
	kernel_universal_unpack
}

src_compile() {
	local my_defconfig hcflags

	# Avoid issues w/ ARCH
	set_arch_to_kernel

	# Imported from linux26-headers
	# autoconf.h isnt generated unless it already exists. plus, we have no guarentee that 
	# any headers are installed on the system...
	[ -f ${ROOT}/usr/include/linux/autoconf.h ] || touch ${S}/include/linux/autoconf.h

	# CFLAGS for the kernel defconfig
	hcflags="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include/"

	# Set the right defconfig
	if use cobalt; then
		my_defconfig="cobalt_defconfig"
	else
		# SGI Machine?
		case "$(uname -i)" in
			"SGI Indy"|"SGI Indigo2"|"SGI IP22")	my_defconfig="ip22_defconfig" ;;
			"SGI Origin"|"SGI IP27")		my_defconfig="ip27_defconfig" ;;
			"SGI Octane"|"SGI IP30")		my_defconfig="ip27_defconfig" ;;
			"SGI O2"|"SGI IP32")			my_defconfig="ip32_defconfig" ;;
		esac
	fi

	# Run defconfig
	make ${my_defconfig} HOSTCFLAGS="${hcflags}" CC="${CC}" CROSS_COMPILE= CHOST="${CHOST}"

	# "Prepare" certain files
	make prepare HOSTCFLAGS="${hcflags}" CC="${CC}" CROSS_COMPILE= CHOST="${CHOST}"

	# Back to normal
	set_arch_to_portage
}

src_install() {
	# 2.4 kernels symlink 'asm' to 'asm-${ARCH}' in include/
	# 2.6 kernels don't, however.  So we fix this here so kernel.eclass can find the include/asm folder
	ln -sf ${S}/include/asm-${ARCH} ${S}/include/asm

	# Do normal src_install stuff
	kernel_src_install

	# If this is 2.5 or 2.6 headers, then we need asm-generic too
	dodir /usr/include/asm-generic
	cp -ax ${S}/include/asm-generic/* ${D}/usr/include/asm-generic
}

pkg_postinst() {
	kernel_pkg_postinst

	einfo "Kernel headers are usually only used when recompiling glibc, as such, following the installation"
	einfo "of newer headers, it is advised that you re-merge glibc as follows:"
	einfo "emerge glibc"
	einfo "Failure to do so will cause glibc to not make use of newer features present in the updated kernel"
	einfo "headers."
}
