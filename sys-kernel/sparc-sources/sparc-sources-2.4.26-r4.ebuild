# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/sparc-sources/sparc-sources-2.4.26-r4.ebuild,v 1.1 2004/07/16 13:44:21 joker Exp $

IUSE="ultra1"

# Kernel ebuilds using the kernel.eclass can remove any patch that you
# do not want to apply by simply setting the KERNEL_EXCLUDE shell
# variable to the string you want to exclude (for instance
# KERNEL_EXCLUDE="grsecurity" would not patch any patches whose names match
# *grsecurity*).  Kernels are only tested in the default configuration, but
# this may be useful if you know that a particular patch is causing a
# conflict with a patch you personally want to apply, or some other
# similar situation.

ETYPE="sources"
inherit kernel eutils

# OKV=original kernel version, KV=patched kernel version.  They can be the same.
[ "$OKV" == "" ] && OKV="${PV}"

EXTRAVERSION="-${PN/-*/}"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}${EXTRAVERSION}"

PATCH_VERSION="2.4.26-sparc"

# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/sparc-sources-${PV}/patches.txt.gz

DESCRIPTION="Full sources for the Gentoo Sparc Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://gentoo/patches-${PATCH_VERSION}.tar.bz2"

S=${WORKDIR}/linux-${KV}
KEYWORDS="~x86 -ppc ~sparc"
SLOT="${KV}"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die "Error moving kernel source tree to linux-${KV}"
	cd ${PATCH_VERSION} || die "Unable to cd into ${PATCH_VERSION}"

	kernel_src_unpack

	# sparc32 grsec fix
	epatch ${FILESDIR}/2.4.26-use-pte_alloc_one_fast.patch

	# fix format string problem in panic()
	epatch ${FILESDIR}/2.4.26-CAN-2004-0394.patch
	# fix for DECnet
	epatch ${FILESDIR}/2.4.26-CAN-2004-0495.patch
	# fix for e1000 (rumours say some cards work in Sparc)
	epatch ${FILESDIR}/2.4.CAN-2004-0535.patch
	# fix for fs/attr.c
	epatch ${FILESDIR}/2.4-attr-fix.patch

	# Patch the HME driver only on Ultra1 machines.
	use ultra1 && epatch ${FILESDIR}/U1-hme-lockup.patch
}

pkg_postinst() {

	kernel_pkg_postinst

	# Display SUN Ultra 1 HME warning if it can be detected or if the machinetype is unknown.
	if [ ! -r "/proc/openprom/name" -o "`cat /proc/openprom/name 2>/dev/null`" = "'SUNW,Ultra-1'" ]; then
		einfo
		einfo "For users with an Enterprise model Ultra 1 using the HME network interface,"
		einfo "please emerge the kernel using the following command:"
		einfo
		einfo "USE=ultra1 emerge sparc-sources"
		einfo
	fi
}
