# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-sources-benh/ppc-sources-benh-2.4.22-r4.ebuild,v 1.1 2004/01/08 19:19:20 plasmaroo Exp $

IUSE=""

ETYPE="sources"
inherit kernel

# OKV=original kernel version, KV=patched kernel version.  They can be the same.
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-${PN/-*/}"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR/4/2}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}

MY_R=`echo $PR | sed "s:r:ben:g"`

DESCRIPTION="PowerPC kernel tree based on benh's patches, -r corresponds to ben{r} versioning"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	http://www.kernel.org/pub/linux/kernel/people/benh/patch-${OKV}-${MY_R/4/2}.bz2"
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
	patch -p1 < ${WORKDIR}/patch-${OKV}-${MY_R/4/2} || die "patch failed"

	epatch ${FILESDIR}/do_brk_fix.patch || die "Failed to patch do_brk() vulnerability!"
	epatch ${FILESDIR}/${P}.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
	epatch ${FILESDIR}/${P}.rtc_fix.patch || die "Failed to patch RTC vulnerabilities!"

	use xfs && ( ewarn "XFS is no longer included!" )
	EXTRAVERSION="-ben${PR/r4/2}-${PR}" && kernel_universal_unpack
}

src_install() {
	dodir /usr/src
	cd ${S}
	rm ${WORKDIR}/patch-${OKV}-${MY_R}
	echo ">>> Copying sources..."
	mv ${WORKDIR}/* ${D}/usr/src
}
