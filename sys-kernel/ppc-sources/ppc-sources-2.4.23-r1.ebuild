# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-sources/ppc-sources-2.4.23-r1.ebuild,v 1.1 2004/01/08 18:50:38 plasmaroo Exp $

# Whats in this kernel?
#
# Includes
#
# In addition to the standard feature set of kernel.org's 2.4.23, this
# tree includes fixes/updates that didn't make it into 2.4.23, including all
# of what was present as of 2.4.22-ben2. Some of the major additions are:
#
# - G5 support (though 2.6 is recommended on G5s anyway)
# - Laptop mode patch (Jens Axboe). See Documentation/laptop_mode.sh script
# - Andrea Arcangeli's silent-stack-overflow patch
# - CPU Frequency switching support on some laptops
# - Support for UniNorth AGP in the agpgart driver
# - Support for blinking the laptop LED on internal HD activity
# - Improved support for lba48 capable disks (Jens Axboe)
# - Updated rivafb with support for more cards & eMac
# - Updated sungem driver, supports more chips & recent PHYs
# - Updated dmasound driver to support tumbler & snapper
# - Add reporting of OF device path of IDE interfaces in /proc/ide
# - Fixes for CompactFlash cards
# - Fixes to vmlinux.coff oldworld wrapper
# - Better TB sync code for 2 CPU machines from Samuel Rydth
# - Hardware TB sync on core99 (dual G4s)
# - Initial support for iBook G4
# - Fix for Promise IDE controller on Xserve's

IUSE=""

ETYPE="sources"
inherit kernel

# OKV=original kernel version, KV=patched kernel version.  They can be the same.
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"

EXTRAVERSION="-${PN/-*/}"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}

MY_R=`echo $PR | sed "s:r:benh:g" | sed "s:1:0:"`

DESCRIPTION="PowerPC kernel tree based on benh's patches, -r corresponds to ben{r} versioning"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://www.kernel.org/pub/linux/kernel/people/benh/patch-${OKV}-${MY_R}.bz2"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/benh/"
KEYWORDS="-x86 ~ppc -sparc -alpha"
PROVIDE="virtual/linux-sources"
LICENSE="GPL-2"
SLOT="${KV}"
DEPEND=">=sys-devel/binutils-2.11.90.0.31"
RDEPEND=">=sys-libs/ncurses-5.2 dev-lang/perl virtual/modutils sys-devel/make"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} ${PF} || die

	cd ${PF}
	patch -p1 < ${WORKDIR}/patch-${OKV}-${MY_R} || die "patch failed"

	epatch ${FILESDIR}/do_brk_fix.patch || die "Failed to patch do_brk() vulnerability!"
	epatch ${FILESDIR}/${P}.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
	epatch ${FILESDIR}/${P}.rtc_fix.patch || die "Failed to patch RTC vulnerabilities!"

	use xfs && ( ewarn "XFS is no longer included!" )

	EXTRAVERSION="-ben${PR/r1/0}-${PR}" && kernel_universal_unpack
}

src_install() {

	dodir /usr/src
	cd ${S}
	rm ${WORKDIR}/patch-${OKV}-${MY_R}
	echo ">>> Copying sources..."
	mv ${WORKDIR}/* ${D}/usr/src

}
