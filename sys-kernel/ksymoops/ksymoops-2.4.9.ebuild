# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ksymoops/ksymoops-2.4.9.ebuild,v 1.3 2003/12/29 08:00:58 ciaranm Exp $

DESCRIPTION="Utility to decode a kernel oops, or other kernel call traces."
SRC_URI="ftp://ftp.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/${P}.tar.gz"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/ksymoops/"
DEPEND="virtual/glibc >=sys-devel/binutils-2.9.1.0.25"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha mips sparc"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile Makefile.orig
	# static/dynamic hack
	# unfortunately, binutils and gcc ebuilds both install a libiberty.a
	# and gcc's is not compatible with binutils libbfd.a
	# linking against a bad mixuture results in missing symbols.
	# linking against the shared (dynamic) objects seems to work.
	sed -e "/^STATIC/s:-Bstatic:-Bdynamic:" -e "s:-O2:${CFLAGS}:" < \
		Makefile.orig > Makefile
	# Note: this problem is fixed as of gcc-2.95.3-r6, so we can remove this
	# fix eventually
}

src_compile() {
	emake all || die
}

src_install() {
	into /
	dosbin ksymoops
	doman ksymoops.8
	dodoc Changelog README README.XFree86
}
