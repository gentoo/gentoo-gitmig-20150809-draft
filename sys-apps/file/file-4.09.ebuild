# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-4.09.ebuild,v 1.12 2004/07/28 16:12:07 vapier Exp $

inherit flag-o-matic gnuconfig eutils distutils

DESCRIPTION="Program to identify a file's format by scanning binary data for patterns"
HOMEPAGE="ftp://ftp.astron.com/pub/file/"
SRC_URI="ftp://ftp.gw.com/mirrors/pub/unix/file/${P}.tar.gz
	ftp://ftp.astron.com/pub/file/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ~ia64 ~ppc64 s390"
IUSE="python build"

DEPEND="virtual/libc
	!build? ( python? ( virtual/python ) )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# (12 Oct 2003) <kumba@gentoo.org>
	# This patch is for MIPS only.  It slightly changes the 'file' output
	# on MIPS machines to a specific format so that other programs can
	# recognize things.
	use mips && epatch ${FILESDIR}/${PN}-4.xx-mips-gentoo.diff

	# uclibc support
	epatch ${FILESDIR}/${PN}-4.08-uclibc.patch
	epatch ${FILESDIR}/ltconfig-uclibc.patch

	# gnuconfig_update should run for every arch/libc combo not just mips.
	gnuconfig_update

	# make sure python links against the current libmagic #54401
	sed -i "/library_dirs/s:'\.\./src':'../src/.libs':" python/setup.py
}

src_compile() {
	# file command segfaults on hppa -  reported by gustavo@zacarias.com.ar
	[ ${ARCH} = "hppa" ] && filter-flags "-mschedule=8000"

	econf --datadir=/usr/share/misc || die

	# Buggy Makefiles.  This fixes bug 31356
	emake -j1 || die "emake failed"

	use python && cd python && distutils_src_compile
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	if ! use build ; then
		dodoc ChangeLog MAINT README
		use python && cd python && distutils_src_install
	else
		rm -rf ${D}/usr/share/man ${D}/usr/lib/*.a
	fi
}

pkg_postinst() {
	use python && distutils_pkg_postinst
}

pkg_postrm() {
	use python && distutils_pkg_postrm
}
