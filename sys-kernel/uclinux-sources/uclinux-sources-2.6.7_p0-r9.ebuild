# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/uclinux-sources/uclinux-sources-2.6.7_p0-r9.ebuild,v 1.1 2004/11/20 11:26:08 plasmaroo Exp $

IUSE=""

ETYPE="sources"
inherit kernel eutils
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"

EXTRAVERSION="uc${PV/*_p/}"
[ "${PR}" != "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
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
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0415.patch
	http://dev.gentoo.org/~plasmaroo/patches/kernel/misc/security/linux-${OKV}-CAN-2004-0814.patch"

HOMEPAGE="http://www.uclinux.org/"
KEYWORDS="~x86 -ppc"
SLOT="${KV}"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die

	cd linux-${KV}
	epatch ../${MY_P/linux/${base}}.${patch} || die "Failed to apply uClinux patch!"
	epatch ${DISTDIR}/linux-${OKV}-CAN-2004-0415.patch || die "Failed to add the CAN-2004-0415 patch!"
	epatch ${FILESDIR}/${PN}.CAN-2004-0497.patch || die "Failed to add the CAN-2004-0497 patch!"
	epatch ${FILESDIR}/${PN}-2.6.CAN-2004-0596.patch || die "Failed to apply the CAN-2004-0596 security patch!"
	epatch ${DISTDIR}/linux-${OKV}-CAN-2004-0814.patch || die "Failed to add the CAN-2004-0814 patch!"
	epatch ${FILESDIR}/${PN}-2.6.IPTables-RDoS.patch || die "Failed to apply the IPTables RDoS security patch!"
	epatch ${FILESDIR}/${PN}-2.6.ProcPerms.patch || die "Failed to apply the /proc permissions security patch!"
	epatch ${FILESDIR}/${PN}-2.6.cmdlineLeak.patch || die "Failed to apply the /proc/cmdline patch!"
	epatch ${FILESDIR}/${PN}-2.6.CAN-2004-0816.patch || die "Failed to apply the CAN-2004-0816 patch!"
	epatch ${FILESDIR}/${PN}-2.6.devPtmx.patch || die "Failed to apply /dev/ptmx patch!"
	epatch ${FILESDIR}/${PN}-2.6.binfmt_elf.patch || die "Failed to apply binfmt_elf patch!"
	epatch ${FILESDIR}/${PN}-2.6.smbfs.patch || die "Failed to apply SMBFS patch!"

	set MY_ARCH=${ARCH}
	unset ARCH
	rm ../${MY_P/linux/${base}}.${patch}

	kernel_universal_unpack
	set ARCH=${MY_ARCH}
}
