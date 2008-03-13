# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mindi-busybox/mindi-busybox-1.7.3.ebuild,v 1.1 2008/03/13 11:04:02 wschlich Exp $

inherit eutils flag-o-matic

DESCRIPTION="The rescue part of a program that creates emergency boot disks/CDs using your kernel, tools and modules."
HOMEPAGE="http://www.mondorescue.org"
SRC_URI="ftp://ftp.mondorescue.org/src/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"
DEPEND="virtual/libc"
RDEPEND=">=app-arch/bzip2-0.9
		sys-devel/binutils"

src_compile() {
	make oldconfig > /dev/null
	# work around broken ass powerpc compilers
	emake EXTRA_CFLAGS="${CFLAGS}" busybox || die "build failed"
}

src_install() {
	# bundle up the symlink files for use later
	emake CONFIG_PREFIX="${D}/usr/lib/mindi/rootfs" install || die
}
