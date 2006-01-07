# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-4.0.1.ebuild,v 1.12 2006/01/07 03:31:54 vapier Exp $

PATCH_VER="1.0"
PATCH_GCC_VER="4.0.1"
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

inherit toolchain

DESCRIPTION="The GNU Compiler Collection.  Includes C/C++, java compilers, pie+ssp extensions, Haj Ten Brugge runtime bounds checking"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="-*"

RDEPEND="!sys-devel/hardened-gcc
	|| ( app-admin/eselect-compiler >=sys-devel/gcc-config-1.3.10 )
	>=sys-libs/zlib-1.1.4
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
if [[ ${CATEGORY} != cross-* ]] ; then
	RDEPEND="${RDEPEND} elibc_glibc? ( >=sys-libs/glibc-2.3.6 )"
fi
DEPEND="${RDEPEND}
	>=sys-apps/texinfo-4.2-r4
	>=sys-devel/bison-1.875
	>=${CATEGORY}/binutils-2.15.94"

PDEPEND="|| ( app-admin/eselect-compiler sys-devel/gcc-config )
	x86? ( !nocxx? ( !elibc_uclibc? ( !build? ( =virtual/libstdc++-3.3 ) ) ) )"

pkg_postinst() {
	toolchain_pkg_postinst

	einfo "This gcc-4 ebuild is provided for your convenience, and the use"
	einfo "of this compiler is not supported by the Gentoo Developers."
	einfo "Please file bugs related to gcc-4 with upstream developers."
	einfo "Compiler bugs should be filed at http://gcc.gnu.org/bugzilla/"
}
