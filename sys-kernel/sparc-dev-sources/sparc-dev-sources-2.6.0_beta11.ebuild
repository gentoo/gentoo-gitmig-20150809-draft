# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/sparc-dev-sources/sparc-dev-sources-2.6.0_beta11.ebuild,v 1.1 2003/12/15 03:21:12 wesolows Exp $

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
inherit kernel

#Original Kernel Version before Patches
# eg: 2.6.0-test11
OKV=${PV/_beta/-test}
OKV=${OKV/-r*//}

#Kernel version after patches
# eg: 2.6.0-test8-bk1
KV=${PV/_beta/-test}
KV="${KV}-${PN/-*/}"

[ ! "${PR}" == "r0" ] && KV="${KV}-${PR}"

# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/sparc-sources-dev-${PV}/patches.txt.gz

DESCRIPTION="Full sources for the Gentoo Sparc Linux development kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.6/linux-${OKV}.tar.bz2
	mirror://gentoo/patches-${KV}.tar.bz2"

S=${WORKDIR}/linux-${KV}
KEYWORDS="~x86 -ppc ~sparc"
SLOT="${KV}"

DEPEND="${DEPEND} sys-apps/module-init-tools"
[ `uname -m` = "sparc64" ] && DEPEND="${DEPEND} >=sys-devel/gcc-sparc64-3.2.3"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die "Error moving kernel source tree to linux-${KV}"
	cd ${KV} || die "Unable to cd into ${KV}"

	kernel_src_unpack

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
		einfo "USE=ultra1 emerge sparc-sources-dev"
		einfo
	fi
}
