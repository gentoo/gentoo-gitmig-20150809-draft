# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hppa-dev-sources/hppa-dev-sources-2.6.7_p14.ebuild,v 1.1 2004/07/24 07:08:29 vapier Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel-2 eutils
OKV="${PV/_p*/}"
PATCH_LEVEL="${PV/${OKV}_p/}"
EXTRAVERSION="-pa${PATCH_LEVEL}"
[ ! "${PR}" = "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV=${OKV}${EXTRAVERSION}
S=${WORKDIR}/linux-${KV}


DESCRIPTION="Full sources for the Linux kernel with patch for hppa"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2 http://ftp.parisc-linux.org/cvs/linux-2.6/patch-${OKV}-pa${PATCH_LEVEL}.gz"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://parisc-linux.org"
KEYWORDS="hppa -*"
IUSE=""
SLOT="${KV}"


src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${KV}
	cd ${S}

	epatch ${DISTDIR}/patch-${OKV}-pa${PATCH_LEVEL}.gz
	epatch ${FILESDIR}/ncr53c8xx.diff
	epatch ${FILESDIR}/CAN-2004-0626-death_packet.patch
	epatch ${FILESDIR}/CAN-2004-0497.patch

}
