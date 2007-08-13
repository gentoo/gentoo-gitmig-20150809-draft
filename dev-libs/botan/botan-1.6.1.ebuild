# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/botan/botan-1.6.1.ebuild,v 1.5 2007/08/13 20:19:35 dertobi123 Exp $

inherit eutils multilib

MY_PN="Botan"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="A C++ crypto library"
HOMEPAGE="http://botan.randombit.net/"
SRC_URI="http://botan.randombit.net/files/${MY_P}.tgz"

KEYWORDS="~amd64 ppc sparc x86"
SLOT="0"
LICENSE="BSD"
IUSE="bzip2 gmp ssl zlib"

S="${WORKDIR}/${MY_P}"

RDEPEND="bzip2? ( >=app-arch/bzip2-1.0.3 )
	zlib? ( >=sys-libs/zlib-1.2.3 )
	gmp? ( >=dev-libs/gmp-4.2.1 )
	ssl? ( >=dev-libs/openssl-0.9.8c )"

# configure.pl requires Getopt::Long, File::Spec, and File::Copy;
# all seem included in dev-lang/perl ATM.
DEPEND="${RDEPEND}
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-asm.patch"
}

src_compile() {
	# Modules that should work under any semi-recent Unix
	local modules="alloc_mmap,es_egd,es_ftw,es_unix,fd_unix,ml_unix,tm_unix,tm_posix,mux_pthr"

	if useq bzip2; then modules="$modules,comp_bzip2"; fi
	if useq zlib; then modules="$modules,comp_zlib"; fi
	if useq gmp; then modules="$modules,eng_gmp"; fi
	if useq ssl; then modules="$modules,eng_ossl"; fi

	# This is also supported on i586+ - hope this is correct.
	# documention says sparc though not enables because of
	# http://bugs.gentoo.org/show_bug.cgi?id=71760#c11

	if [ "${ARCH}" = "alpha" -o "${ARCH}" = "amd64" ] || \
			[ "${ARCH}" = "x86" -a "${CHOST:0:4}" != "i386" -a "${CHOST:0:4}" != "i486" ]; then
		modules="$modules,tm_hard"
	fi

	# If we have assembly code for this machine, use it
	if [ "${ARCH}" = "x86" ]; then
		modules="$modules,mp_ia32,alg_ia32"
	elif [ "${ARCH}" = "amd64" ]; then
		modules="$modules,mp_amd64,alg_amd64"
	elif [ "${ARCH}" = "alpha" -o "${ARCH}" = "ia64" -o \
		"${ARCH}" = "ppc64" -o "${PROFILE_ARCH}" = "mips64"  ]; then
		modules="$modules,mp_asm64"
	fi

	# Enable v9 instructions for sparc64
	if [ "${PROFILE_ARCH}" = "sparc64" ]; then
		CHOSTARCH="sparc32-v9"
	else
		CHOSTARCH="$(echo ${CHOST} | cut -d - -f 1)"
	fi

	cd "${S}"
	elog "Enabling modules: " ${modules}

	# FIXME: We might actually be on *BSD or OS X...
	./configure.pl \
		--noauto gcc-linux-${CHOSTARCH} \
		--libdir=/usr/$(get_libdir) \
		--modules=$modules ||
			die "configure.pl failed"
	emake "LIB_OPT=${CXXFLAGS}" "MACH_OPT=" || die "emake failed"
}

src_test() {
	chmod -R ugo+rX "${S}"
	emake check || die "emake check failed"
	env LD_LIBRARY_PATH="${S}" ./check --validate || die "validation tests failed"
}

src_install() {
	make INSTALLROOT="${D}/usr" install || die "make install failed"
}
