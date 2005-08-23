# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/perfctr/perfctr-2.7.18.ebuild,v 1.1 2005/08/23 05:49:34 robbat2 Exp $

inherit multilib

DESCRIPTION="Linux performance monitoring counters"
HOMEPAGE="http://user.it.uu.se/~mikpe/linux/perfctr/2.7/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 -alpha -arm -hppa -ia64 -m68k -mips -s390 -sh -sparc"
# Should work on: ppc ppc64
# but needs testing
# this is a hardware-specific package, with support for only x86/amd64/ppc/ppc64
IUSE=""

DEPEND="virtual/libc sys-kernel/linux-headers"
RDEPEND="virtual/libc"

src_compile() {
	emake CFLAGS="${CFLAGS}"
}

src_install() {
	pfx="${D}/usr"
	make install2 PREFIX="${pfx}" BINDIR="${pfx}/sbin" LIBDIR="${pfx}/$(get_libdir)" INCLDIR="${pfx}/include/"
	dodoc CHANGES OTHER README TODO
}
