# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/wolk-sources/wolk-sources-3.8.ebuild,v 1.9 2003/11/20 07:43:38 lostlogic Exp $

IUSE="build"

ETYPE="sources"
inherit kernel

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

OKV=2.4.18
KV=${OKV}-wolk$(echo ${PV} | sed s:_:-:)
EXTRAVERSION=-wolk$(echo ${PV} | sed s:_:-:)
S=${WORKDIR}/linux-${KV}

DESCRIPTION="Working Overloaded Linux Kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://sourceforge/wolk/linux-${KV}-patchset.tar.bz2"
KEYWORDS="~x86"
SLOT="${KV}"
HOMEPAGE="http://wolk.sourceforge.net http://www.kernel.org"

src_unpack() {

	unpack linux-${OKV}.tar.bz2
	mv linux linux-${KV} || die

	unpack linux-${KV}-patchset.tar.bz2
	cd linux-${KV}-patchset

	kernel_src_unpack

	cd ${WORKDIR}
	rm -rf linux-${KV}-patchset

	cd ${WORKDIR}/linux-${KV}
}
