# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-4.06.ebuild,v 1.21 2004/07/15 01:45:13 agriffis Exp $

inherit flag-o-matic gnuconfig eutils

DESCRIPTION="Program to identify a file's format by scanning binary data for patterns"
HOMEPAGE="ftp://ftp.astron.com/pub/file/"
SRC_URI="ftp://ftp.gw.com/mirrors/pub/unix/file/${P}.tar.gz
	ftp://ftp.astron.com/pub/file/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc sparc mips alpha hppa amd64 ia64 ppc64"
IUSE="build uclibc"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# (12 Oct 2003) <kumba@gentoo.org>
	# This patch is for MIPS only.  It slightly changes the 'file' output
	# on MIPS machines to a specific format so that other programs can
	# recognize things.
	if [ "${ARCH}" = "mips" ]; then
		epatch ${FILESDIR}/${PN}-4.xx-mips-gentoo.diff
	fi
	# uclibc support
	epatch ${FILESDIR}/${PN}-4.08-uclibc.patch
	epatch ${FILESDIR}/ltconfig-uclibc.patch
}

src_compile() {

	# If running mips64 or uclibc, we need updated configure data
	gnuconfig_update

	# file command segfaults on hppa -  reported by gustavo@zacarias.com.ar
	[ ${ARCH} = "hppa" ] && filter-flags "-mschedule=8000"

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--datadir=/usr/share/misc \
		--host=${CHOST} || die

	# Buggy Makefiles.  This fixes bug 31356
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	if ! use build ; then
		dodoc ChangeLog LEGAL.NOTICE MAINT README || die "dodoc failed"
	else
		rm -rf ${D}/usr/share/man
	fi
}
