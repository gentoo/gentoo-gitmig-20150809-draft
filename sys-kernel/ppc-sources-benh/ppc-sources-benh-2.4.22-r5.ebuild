# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-sources-benh/ppc-sources-benh-2.4.22-r5.ebuild,v 1.1 2004/02/19 10:04:18 plasmaroo Exp $

IUSE=""

ETYPE="sources"
inherit kernel

# OKV=original kernel version, KV=patched kernel version.  They can be the same.
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-${PN/-*/}"
EXTRAVERSION="${EXTRAVERSION}-${PR/5/2}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}
MY_R=`echo $PR | sed "s:r:ben:g"`

DESCRIPTION="PowerPC kernel tree based on benh's patches, -r corresponds to ben{r} versioning"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://www.kernel.org/pub/linux/kernel/people/benh/patch-${OKV}-${MY_R/5/2}.bz2"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/benh/"
KEYWORDS="-x86 ppc -sparc -alpha ppc64"
PROVIDE="virtual/linux-sources"
LICENSE="GPL-2"
SLOT="${KV}"
DEPEND=">=sys-devel/binutils-2.11.90.0.31"
RDEPEND=">=sys-libs/ncurses-5.2 dev-lang/perl virtual/modutils sys-devel/make"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} ${PF} || die

	cd ${PF}
	patch -p1 < ${WORKDIR}/patch-${OKV}-${MY_R/5/2} || die "patch failed"

	epatch ${FILESDIR}/do_brk_fix.patch || die "Failed to patch do_brk() vulnerability!"
	epatch ${FILESDIR}/${P}.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
	epatch ${FILESDIR}/${P}.rtc_fix.patch || die "Failed to patch RTC vulnerabilities!"
	epatch ${FILESDIR}/${P}.munmap.patch || die "Failed to apply munmap patch!"

	use xfs && ( ewarn "XFS is no longer included!" )
	EXTRAVERSION="-ben${PR/r5/2}-${PR}" && kernel_universal_unpack
}

src_install() {
	dodir /usr/src
	cd ${S}
	rm ${WORKDIR}/patch-${OKV}-${MY_R/5/2}
	echo ">>> Copying sources..."
	mv ${WORKDIR}/* ${D}/usr/src
}
