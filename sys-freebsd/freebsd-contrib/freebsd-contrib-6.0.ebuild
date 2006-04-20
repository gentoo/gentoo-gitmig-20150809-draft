# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-contrib/freebsd-contrib-6.0.ebuild,v 1.2 2006/04/20 07:20:43 flameeyes Exp $

inherit bsdmk freebsd flag-o-matic

GCC="freebsd-gcc-3.4.2"

DESCRIPTION="Contributed sources for FreeBSD."
SLOT="0"
KEYWORDS="~x86-fbsd"
LICENSE="BSD GPL-2 as-is"

IUSE="ssl kerberos"

SRC_URI="mirror://gentoo/${GNU}.tar.bz2
	mirror://gentoo/${GCC}.tar.bz2
	mirror://gentoo/${P}.tar.bz2"

RDEPEND="kerberos? ( virtual/krb5 )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-sources-${RV}*
	=sys-freebsd/freebsd-mk-defs-${RV}*"

S="${WORKDIR}/gnu"

pkg_setup() {
	if use kerberos && ! use ssl; then
		error "You can't install with kerberos support and no ssl support"
	fi

	use ssl || mymakeopts="${mymakeopts} NO_OPENSSL= NO_CRYPT= "
	use kerberos || mymakeopts="${mymakeopts} NO_KERBEROS= "
}

REMOVE_SUBDIRS="lib/libg2c lib/libgcc lib/libgcc_r lib/libgcov lib/libiberty
	lib/libobjc lib/libreadline lib/libregex lib/libstdc++ lib/libsupc++ usr.bin/bc
	usr.bin/binutils usr.bin/cc usr.bin/cpio usr.bin/cvs usr.bin/dc usr.bin/dialog
	usr.bin/diff usr.bin/diff3 usr.bin/gdb usr.bin/gperf usr.bin/grep usr.bin/groff
	usr.bin/gzip usr.bin/man usr.bin/rcs usr.bin/sdiff usr.bin/send-pr
	usr.bin/tar usr.bin/texinfo"

PATCHES="${FILESDIR}/${PN}-5.3-lib_csu-makefile.patch"

