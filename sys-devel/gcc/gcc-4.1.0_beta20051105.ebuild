# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-4.1.0_beta20051105.ebuild,v 1.1 2005/11/05 19:47:57 halcy0n Exp $

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
	elibc_glibc? ( >=sys-libs/glibc-2.3.5 )
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
	>=sys-devel/binutils-2.15.97"

PDEPEND="sys-devel/gcc-config
	!nocxx? ( !n32? ( !n64? ( !uclibc? ( !build? ( sys-libs/libstdc++-v3 ) ) ) ) )"

pkg_setup() {
	if [ -z $I_PROMISE_TO_SUPPLY_PATCHES_WITH_BUGS ] ; then
		die "Please \`export I_PROMISE_TO_SUPPLY_PATCHES_WITH_BUGS=1\` or define it in your make.conf if you want to use this ebuild.  This is to try and cut down on people filing bugs for a compiler we do not currently support."
	fi
}

src_unpack() {
	toolchain_src_unpack

	echo ${PV/_/-} > "${S}"/gcc/BASE-VER
	echo "" > "${S}"/gcc/DATESTAMP
}

pkg_postinst() {
	toolchain_pkg_postinst

	einfo "This gcc-4 ebuild is provided for your convenience, and the use"
	einfo "of this compiler is not supported by the Gentoo Developers."
	einfo "Please file bugs related to gcc-4 with upstream developers."
	einfo "Compiler bugs should be filed at http://gcc.gnu.org/bugzilla/"
}
