# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-4.0.0_beta20050326.ebuild,v 1.1 2005/03/28 03:42:03 halcy0n Exp $

ETYPE="gcc-compiler"

inherit toolchain

DESCRIPTION="The GNU Compiler Collection.  Includes C/C++, java compilers, pie+ssp extensions, Haj Ten Brugge runtime bounds checking"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="-*"

RDEPEND="virtual/libc
	>=sys-devel/gcc-config-1.3.1
	>=sys-libs/zlib-1.1.4
	!sys-devel/hardened-gcc
	!uclibc? (
		>=sys-libs/glibc-2.3.3_pre20040420-r1
		hardened? ( >=sys-libs/glibc-2.3.3_pre20040529 )
	)
	amd64? ( multilib? ( >=app-emulation/emul-linux-x86-glibc-1.1 ) )
	fortran? ( dev-libs/gmp )
	!build? (
		gcj? (
			gtk? ( >=x11-libs/gtk+-2.2 )
			>=media-libs/libart_lgpl-2.1
		)
		>=sys-libs/ncurses-5.2-r2
		nls? ( sys-devel/gettext )
	)"


if [[ ${CATEGORY/cross-} != ${CATEGORY} ]]; then
	RDEPEND="${RDEPEND} ${CATEGORY}/binutils"
fi

DEPEND="${RDEPEND}
	>=sys-apps/texinfo-4.2-r4
	>=sys-devel/bison-1.875
	>=sys-devel/binutils-2.15.90.0.1.1-r1"

PDEPEND="sys-devel/gcc-config
	!nocxx? ( !n32? ( !n64? ( !uclibc? ( !build? ( sys-libs/libstdc++-v3 ) ) ) ) )"

pkg_postinst() {
	toolchain_pkg_postinst

	einfo "This gcc-4 ebuild is provided for your convenience, and the use"
	einfo "of this compiler is not supported by the Gentoo Developers."
	einfo "Please file bugs related to gcc-4 with upstream developers."
	einfo "Compiler bugs should be filed at http://gcc.gnu.org/bugzilla/"
}
