# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nacl-toolchain-newlib/nacl-toolchain-newlib-0_p6852.ebuild,v 1.1 2011/10/06 18:52:19 phajdan.jr Exp $

EAPI="4"

inherit eutils multilib

BINUTILS_PV="2.20.1"
NEWLIB_PV="1.18.0"
GCC_PV="4.4.3"
GMP_PV="5.0.2"
MPFR_PV="3.0.1"
MPC_PV="0.9"
PPL_PV="0.11.2"
CLOOG_PPL_PV="0.15.9"
NACL_REVISION="${PV##*_p}"

DESCRIPTION="Native Client newlib-based toolchain (only for compiling IRT)"
HOMEPAGE="http://code.google.com/chrome/nativeclient/"
SRC_URI="mirror://gnu/binutils/binutils-${BINUTILS_PV}.tar.bz2
	ftp://sources.redhat.com/pub/newlib/newlib-${NEWLIB_PV}.tar.gz
	mirror://gnu/gcc/gcc-${GCC_PV}/gcc-${GCC_PV}.tar.bz2
	mirror://gnu/gmp/gmp-${GMP_PV}.tar.bz2
	http://www.mpfr.org/mpfr-${MPFR_PV}/mpfr-${MPFR_PV}.tar.bz2
	http://www.multiprecision.org/mpc/download/mpc-${MPC_PV}.tar.gz
	http://www.cs.unipr.it/ppl/Download/ftp/releases/ppl-${PPL_PV}/ppl-${PPL_PV}.tar.bz2
	ftp://gcc.gnu.org/pub/gcc/infrastructure/cloog-ppl-${CLOOG_PPL_PV}.tar.gz
	http://gsdview.appspot.com/nativeclient-archive2/x86_toolchain/r${NACL_REVISION}/nacltoolchain-buildscripts-r${NACL_REVISION}.tar.gz
	http://gsdview.appspot.com/nativeclient-archive2/x86_toolchain/r${NACL_REVISION}/naclbinutils-${BINUTILS_PV}-r${NACL_REVISION}.patch
	http://gsdview.appspot.com/nativeclient-archive2/x86_toolchain/r${NACL_REVISION}/naclnewlib-${NEWLIB_PV}-r${NACL_REVISION}.patch
	http://gsdview.appspot.com/nativeclient-archive2/x86_toolchain/r${NACL_REVISION}/naclgcc-${GCC_PV}-r${NACL_REVISION}.patch
"

LICENSE="BSD" # NaCl
LICENSE+=" || ( GPL-3 LGPL-3 )" # binutils
LICENSE+=" GPL-3 LGPL-3 || ( GPL-3 libgcc libstdc++ gcc-runtime-library-exception-3.1 ) FDL-1.2" # gcc
LICENSE+=" LGPL-3" # gmp
LICENSE+=" LGPL-2.1" # mpfr, mpc
LICENSE+=" GPL-3" # ppl
LICENSE+=" GPL-2" # cloog-ppl

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	app-arch/zip
	app-arch/unzip
	>=media-libs/libart_lgpl-2.1
	>=sys-apps/texinfo-4.8
	>=sys-devel/binutils-2.15.94
	>=sys-devel/bison-1.875
	>=sys-devel/flex-2.5.4
	sys-devel/gnuconfig
	sys-devel/m4
	>=sys-libs/glibc-2.8
	>=sys-libs/ncurses-5.2-r2
	>=sys-libs/zlib-1.1.4
	>=sys-apps/sed-4
	sys-devel/gettext
	virtual/libiconv
	virtual/yacc
"
RDEPEND=">=sys-libs/zlib-1.1.4"

S="${WORKDIR}"

src_prepare() {
	mv binutils-${BINUTILS_PV} naclbinutils-${BINUTILS_PV}-r${NACL_REVISION} || die
	mv newlib-${NEWLIB_PV} naclnewlib-${NEWLIB_PV}-r${NACL_REVISION} || die
	mv gcc-${GCC_PV} naclgcc-${GCC_PV}-r${NACL_REVISION} || die
	EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" epatch "${DISTDIR}"
	mkdir SRC || die
	mv naclbinutils-${BINUTILS_PV}-r${NACL_REVISION} SRC/binutils || die
	mv naclnewlib-${NEWLIB_PV}-r${NACL_REVISION} SRC/newlib || die
	mv naclgcc-${GCC_PV}-r${NACL_REVISION} SRC/gcc || die

	mv gmp-${GMP_PV} SRC || die
	mv mpfr-${MPFR_PV} SRC || die
	mv mpc-${MPC_PV} SRC || die
	mv ppl-${PPL_PV} SRC || die
	mv cloog-ppl-${CLOOG_PPL_PV} SRC || die
}

src_compile() {
	emake TOOLCHAINNAME="${PN}" build-with-newlib
}

src_install() {
	local TOOLCHAIN_HOME="/usr/$(get_libdir)"
	dodir "${TOOLCHAIN_HOME}"
	insinto "${TOOLCHAIN_HOME}"
	doins -r "${WORKDIR}/out/${PN}"
}
