# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/hppa-headers/hppa-headers-2.4.20_p32.ebuild,v 1.1 2003/04/03 20:07:00 gmsoft Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

IUSE=""
DEPEND=""

ETYPE="headers"
inherit kernel eutils

# What's in this kernel?
# INCLUDED:
#   stock 2.4.20 kernel sources
#   hppa patches 

DESCRIPTION="Full sources for the Linux kernel pathed for hppa"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://parisc-linux.org/"
KEYWORDS="hppa -*"

# set the kernel version now
OKV=2.4.20
PATCH_LEVEL=${PV/${OKV}_p/}
EXTRAVERSION="pa${PATCH_LEVEL}"
KV="${OKV}-${EXTRAVERSION}"
S=${WORKDIR}/linux-${KV}
SLOT="0"

# testing kernel patch
EXTRA_KERNEL_PATCH="patch-${KV}"


SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2 \
	http://ftp.parisc-linux.org/cvs/patch-${KV}.diff.gz"


src_unpack() {
	# base vanilla source
	unpack "linux-${OKV}.tar.bz2" || die
	[ "${OKV}" != "${KV}" ] && \
		mv "${WORKDIR}/linux-${OKV}" "${WORKDIR}/linux-${KV}"

	# do the actual patching
	cd ${S} || die
	einfo "Applying patches for hppa ..."
	unpack patch-${KV}.diff.gz
	patch -p 1 < ${S}/patch-${KV}.diff
	einfo "... Done"
			
	kernel_universal_unpack
}

