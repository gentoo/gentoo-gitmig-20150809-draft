# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vanilla-sources/vanilla-sources-2.4.20.ebuild,v 1.16 2004/07/15 05:28:49 agriffis Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel eutils

OKV=2.4.20
KV=2.4.20
EXTRAVERSION=" "
S=${WORKDIR}/linux-${KV}

# What's in this kernel?

# INCLUDED:
# stock 2.4.20 kernel sources

DESCRIPTION="Full sources for the Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
KEYWORDS="x86 -ppc sparc alpha"
IUSE=""
SLOT="${KV}"

src_unpack() {
	unpack linux-${OKV}.tar.bz2

	cd ${S}

	epatch ${FILESDIR}/do_brk_fix.patch || die "failed to patch for do_brk vuln"

	kernel_universal_unpack
}
