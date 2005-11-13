# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-4.0.2-r1.ebuild,v 1.9 2005/11/13 04:24:40 vapier Exp $

PATCH_VER="1.2"
PATCH_GCC_VER="4.0.2"
UCLIBC_VER="1.0"
UCLIBC_GCC_VER="4.0.0"
PIE_VER="8.7.8"
PIE_GCC_VER="4.0.0"
PP_VER=""
HTB_VER="1.00"

ETYPE="gcc-compiler"

# whether we should split out specs files for multiple {PIE,SSP}-by-default
# and vanilla configurations.
SPLIT_SPECS=no #${SPLIT_SPECS-true} hard disable until #106690 is fixed

# this patch is broken and causes ICEs in a few packages.  I'll remove it on the
# next revbump
GENTOO_PATCH_EXCLUDE="28_all_gcc4-pr19520.patch"

inherit toolchain

DESCRIPTION="The GNU Compiler Collection.  Includes C/C++, java compilers, pie+ssp extensions, Haj Ten Brugge runtime bounds checking"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="-*"

RDEPEND="virtual/libc
	|| ( app-admin/eselect-compiler >=sys-devel/gcc-config-1.3.10 )
	>=sys-libs/zlib-1.1.4
	!sys-devel/hardened-gcc
	elibc_glibc? ( >=sys-libs/glibc-2.3.5 )
	amd64? ( multilib? ( >=app-emulation/emul-linux-x86-glibc-1.1 ) )
	fortran? (
	  dev-libs/gmp
	  dev-libs/mpfr
	)
	!build? (
		gcj? (
			gtk? ( >=x11-libs/gtk+-2.2 )
			>=media-libs/libart_lgpl-2.1
		)
		>=sys-libs/ncurses-5.2-r2
		nls? ( sys-devel/gettext )
	)"

DEPEND="${RDEPEND}
	>=sys-apps/texinfo-4.2-r4
	>=sys-devel/bison-1.875
	>=${CATEGORY}/binutils-2.16.1"

PDEPEND="|| ( app-admin/eselect-compiler sys-devel/gcc-config )
	x86? ( !nocxx? ( !elibc_uclibc? ( !build? ( || ( sys-libs/libstdc++-v3 =sys-devel/gcc-3.3* ) ) ) ) )"

src_unpack() {
	gcc_src_unpack

	[[ ${CHOST} == ${CTARGET} ]] && epatch "${FILESDIR}"/gcc-spec-env.patch

	# Fix cross-compiling
	epatch "${FILESDIR}"/4.0.2/gcc-4.0.2-cross-compile.patch
}

pkg_postinst() {
	toolchain_pkg_postinst

	einfo "This gcc-4 ebuild is provided for your convenience, and the use"
	einfo "of this compiler is not supported by the Gentoo Developers."
	einfo "Please file bugs related to gcc-4 with upstream developers."
	einfo "Compiler bugs should be filed at http://gcc.gnu.org/bugzilla/"
}
