# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/uclinux-sources/uclinux-sources-2.4.26_p0-r10.ebuild,v 1.1 2004/11/27 18:25:13 plasmaroo Exp $

IUSE=""

ETYPE="sources"
inherit kernel eutils
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
POV="${PN}-${OKV}"

EXTRAVERSION="uc${PV/*_p/}"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}-${EXTRAVERSION}"

# Get the major & minor kernel version
MMV=`echo $PV | awk -F. '{print $1"."$2}'`

patch="diff"
base="uClinux"
if [ ${MMV} == "2.6" ]; then
	patch="patch"
	base="linux"
fi

MY_P=linux-${PV/_p/-uc}

S=${WORKDIR}/linux-${KV}
DESCRIPTION="uCLinux kernel patches for CPUs without MMUs"
SRC_URI="mirror://kernel/v${MMV}/linux-${OKV}.tar.bz2
	http://www.uclinux.org/pub/uClinux/uClinux-${MMV}.x/${MY_P/linux/${base}}.${patch}.gz
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/${POV}-CAN-2004-0415.patch
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0814.patch"

HOMEPAGE="http://www.uclinux.org/"
KEYWORDS="~x86 -ppc"
SLOT="${KV}"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die

	cd linux-${KV}
	epatch ../${MY_P/linux/${base}}.${patch} || die "Failed to apply uClinux patch!"

	set MY_ARCH=${ARCH}
	unset ARCH
	rm ../${MY_P/linux/${base}}.${patch}

	epatch ${FILESDIR}/${P}.CAN-2004-0394.patch || die "Failed to add the CAN-2004-0394 patch!"
	epatch ${DISTDIR}/${POV}-CAN-2004-0415.patch || die "Failed to add the CAN-2004-0415 patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-0495.patch || die "Failed to add the CAN-2004-0495 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0497.patch || die "Failed to add the CAN-2004-0497 patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-0535.patch || die "Failed to add the CAN-2004-0535 patch!"
	epatch ${FILESDIR}/${P}.CAN-2004-0685.patch || die "Failed to add the CAN-2004-0685 patch!"
	epatch ${DISTDIR}/linux-${OKV}-CAN-2004-0814.patch || die "Failed to add the CAN-2004-0814 patch!"
	epatch ${FILESDIR}/${P}.FPULockup-53804.patch || die "Failed to apply FPU-lockup patch!"
	epatch ${FILESDIR}/${P}.cmdlineLeak.patch || die "Failed to apply the /proc/cmdline patch!"
	epatch ${FILESDIR}/${P}.XDRWrapFix.patch || die "Failed to apply the kNFSd XDR patch!"
	epatch ${FILESDIR}/${P}.binfmt_elf.patch || die "Failed to apply the binfmt_elf patch!"
	epatch ${FILESDIR}/${P}.smbfs.patch || die "Failed to apply the SMBFS patch!"
	epatch ${FILESDIR}/${PN}.AF_UNIX.patch || die "Failed to apply the AF_UNIX patch!"
	epatch ${FILESDIR}/${P}.binfmt_a.out.patch || die "Failed to apply the a.out patch!"

	kernel_universal_unpack
	set ARCH=${MY_ARCH}
}
