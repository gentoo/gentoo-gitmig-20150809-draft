# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mm-sources/mm-sources-2.6.0_beta2-r2.ebuild,v 1.1 2003/07/31 11:59:34 latexer Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

OKV=${PV/_beta/-test}

EXTRAVERSION="`echo ${OKV}-${PR/r/mm} | \
	sed -e 's/[0-9]\+\.[0-9]\+\.[0-9]\+\(.*\)/\1/'`"

KV=${OKV}-${PR/r/mm}

inherit kernel

# What's in this kernel?

# INCLUDED:
# The development branch of the linux kernel with Andrew Morton's patch

DESCRIPTION="Full sources for the development linux kernel with Andrew Morton's patchset"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${PV/_beta/-test}.tar.bz2
mirror://kernel/linux/kernel/people/akpm/patches/2.6/${PV/_beta/-test}/${KV}/${KV}.bz2"
KEYWORDS="x86 ppc"
SLOT=${KV}

src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2

	mv linux-${OKV} linux-${KV}
	cd ${S}
	bzcat ${DISTDIR}/${KV}.bz2 | patch -p1 || die "mm patch failed"

	unset ARCH
	kernel_universal_unpack

}
