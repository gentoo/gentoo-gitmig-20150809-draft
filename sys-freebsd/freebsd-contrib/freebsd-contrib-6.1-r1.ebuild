# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-contrib/freebsd-contrib-6.1-r1.ebuild,v 1.1 2006/11/22 00:21:44 flameeyes Exp $

inherit bsdmk freebsd flag-o-matic

DESCRIPTION="Contributed sources for FreeBSD."
SLOT="0"
KEYWORDS="~x86-fbsd"
LICENSE="BSD GPL-2 as-is"

IUSE=""

SRC_URI="mirror://gentoo/${GNU}.tar.bz2
	mirror://gentoo/${P}.tar.bz2"

RDEPEND=""
DEPEND="=sys-freebsd/freebsd-sources-${RV}*
	=sys-freebsd/freebsd-mk-defs-${RV}*"

S="${WORKDIR}/gnu"

REMOVE_SUBDIRS="lib/libg2c lib/libgcc lib/libgcc_r lib/libgcov lib/libiberty lib/csu
	lib/libobjc lib/libreadline lib/libregex lib/libstdc++ lib/libsupc++ usr.bin/bc
	usr.bin/binutils usr.bin/cc usr.bin/cpio usr.bin/cvs usr.bin/dc usr.bin/dialog
	usr.bin/diff usr.bin/diff3 usr.bin/gdb usr.bin/gperf usr.bin/grep usr.bin/groff
	usr.bin/gzip usr.bin/man usr.bin/rcs usr.bin/sdiff usr.bin/send-pr
	usr.bin/tar usr.bin/texinfo"

src_install() {
	freebsd_src_install

	# Move these to /bin for boot access
	dodir /bin
	mv "${D}/usr/bin/sort" "${D}/bin/" || die "mv failed"
}
