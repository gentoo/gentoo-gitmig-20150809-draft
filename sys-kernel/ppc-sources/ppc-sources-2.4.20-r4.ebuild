# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-sources/ppc-sources-2.4.20-r4.ebuild,v 1.7 2004/01/08 06:22:58 iggy Exp $

IUSE="build crypt"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

# Kernel ebuilds using the kernel.eclass can remove any patch that you
# do not want to apply by simply setting the KERNEL_EXCLUDE shell
# variable to the string you want to exclude (for instance
# KERNEL_EXCLUDE="evms" would not patch any patches whose names match
# *evms*).  Kernels are only tested in the default configuration, but
# this may be useful if you know that a particular patch is causing a
# conflict with a patch you personally want to apply, or some other
# similar situation.

ETYPE="sources"

inherit kernel
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-${PN/-*/}"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}

SLOT="${KV}"

# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/gentoo-sources-${PV}/patches.txt.gz

DESCRIPTION="Full sources for the Gentoo Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 http://cvs.gentoo.org/~kain/ppc/patches-${KV}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/ http://www.kernel.org/"
LICENSE="GPL-2"
KEYWORDS="-x86 ~ppc -sparc -alpha"
DEPEND=">=sys-devel/binutils-2.11.90.0.31 app-admin/addpatches"
RDEPEND=">=sys-libs/ncurses-5.2 dev-lang/perl >=sys-apps/modutils-2.4.2 sys-devel/make"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die
	cd linux-${KV}
	[ `use crypt` ] || rm 6*
	cd ..
	kernel_src_unpack
}
