# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/botan/botan-1.4.4.ebuild,v 1.1 2004/12/04 05:26:22 dragonheart Exp $

# Comments/fixes to lloyd@randombit.net (author)

DESCRIPTION="A C++ crypto library"
HOMEPAGE="http://botan.randombit.net/"
SRC_URI="http://botan.randombit.net/files/Botan-${PV}.tgz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="BSD"
IUSE="bzlib zlib gmp ssl debug"

S="${WORKDIR}/Botan-${PV}"

# FIXME: libstdc++ here?
RDEPEND="virtual/libc
	bzlib? ( >=app-arch/bzip2-1.0.1 )
	zlib? ( >=sys-libs/zlib-1.1.4 )
	gmp? ( >=dev-libs/gmp-4.1.2 )
	ssl? ( >=dev-libs/openssl-0.9.7d )"

# configure.pl requires DirHandle, Getopt::Long, File::Spec, and File::Copy;
# all seem included in dev-lang/perl ATM.
DEPEND="${RDEPEND}
	dev-lang/perl"

src_compile() {
	# Modules that should work under any semi-recent Unix
	modules="alloc_mmap,es_egd,es_ftw,es_unix,fd_unix,ml_unix,tm_unix,mux_pthr"

	if useq bzlib; then modules="$modules,comp_bzip2"; fi
	if use zlib; then modules="$modules,comp_zlib"; fi
	if use gmp; then modules="$modules,eng_gmp"; fi
	if use ssl; then modules="$modules,eng_ossl"; fi


	# This is also supported on i586+ and sparcv9 - how to test for them? CCHOST?
	if [ ${ARCH} = 'alpha' -o ${ARCH} = 'amd64' ] || \
		[ ${ARCH} = 'x86' -a ${CHOST:0:4} != "i386" -a ${CHOST:0:4} != "i486" ]; then
		modules="$modules,tm_hard"
	fi

	# Also works on mips64 and sparc64
	if [ ${ARCH} = 'alpha' -o ${ARCH} = 'amd64' -o \
		${ARCH} = 'ia64' -o ${ARCH} = 'ppc64' ]; then
		modules="$modules,mp_asm64"
	fi

	# Are there any CHOSTs in use which break this?
	CHOSTARCH=$(echo ${CHOST} | cut -d - -f 1)

	cd ${S}
	einfo "Enabling modules: " $(echo $modules | sed 's/,/ /g')

	# FIXME: We might actually be on *BSD or OS X...
	./configure.pl --noauto gcc-linux-$CHOSTARCH --modules=$modules ||
		die "configure.pl failed"
	emake "LIB_OPT=${CXXFLAGS}" "MACH_OPT=" || die "emake failed"
}

src_test() {
	emake check || die "emake check failed"
	env LD_LIBRARY_PATH=${S} ./check --validate || die "validation tests failed"
}

src_install() {
	make INSTALLROOT="${D}/usr" install || die "make install failed"
}
