# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-sources-benh/ppc-sources-benh-2.4.20-r5.ebuild,v 1.3 2003/02/04 23:07:07 gerk Exp $

IUSE=""

ETYPE="kernel"
inherit kernel

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

MY_R=`echo $PR | sed "s:r:ben:g"`
DESCRIPTION="PowerPC kernel tree based on benh's patches, -r corresponds to ben{r} versioning"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://www.kernel.org/pub/linux/kernel/people/benh/patch-${OKV}-${MY_R}.bz2"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/benh/"
KEYWORDS="-x86 -ppc -sparc -alpha"
LICENSE="GPL-2"
SLOT="${KV}"
DEPEND=">=sys-devel/binutils-2.11.90.0.31"
RDEPEND=">=sys-libs/ncurses-5.2 sys-devel/perl >=sys-apps/modutils-2.4.2 sys-devel/make"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} ${PF} || die

	cd ${PF}
	patch -p1 < ${WORKDIR}/patch-2.4.20-${MY_R} || die "patch failed"

	use xfs && ( ewarn "XFS is no longer included!" )
}

src_install() {
	dodir /usr/src
	cd ${S}
	rm ${WORKDIR}/patch-${OKV}-${MY_R}
	echo ">>> Copying sources..."
	mv ${WORKDIR}/* ${D}/usr/src
}
