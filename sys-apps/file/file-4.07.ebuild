# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-4.07.ebuild,v 1.1 2004/01/21 01:23:17 mr_bones_ Exp $

inherit flag-o-matic gnuconfig

DESCRIPTION="Program to identify a file's format by scanning binary data for patterns"
SRC_URI="ftp://ftp.gw.com/mirrors/pub/unix/file/${P}.tar.gz
	ftp://ftp.astron.com/pub/file/${P}.tar.gz"
HOMEPAGE="ftp://ftp.astron.com/pub/file/"

KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~arm ~alpha hppa mips ia64 ppc64"
SLOT="0"
LICENSE="as-is"
IUSE=""

DEPEND="virtual/glibc"

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
}

src_compile() {

	# If running mips64, we need updated configure data
	use mips && gnuconfig_update

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

	if [ -z "`use build`" ] ; then
		dodoc ChangeLog LEGAL.NOTICE MAINT README || die "dodoc failed"
	else
		rm -rf ${D}/usr/share/man
	fi
}
