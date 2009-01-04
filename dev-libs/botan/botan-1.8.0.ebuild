# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/botan/botan-1.8.0.ebuild,v 1.5 2009/01/04 06:58:55 dragonheart Exp $

inherit eutils multilib toolchain-funcs

MY_PN="Botan"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="A C++ crypto library"
HOMEPAGE="http://botan.randombit.net/"
SRC_URI="http://files.randombit.net/botan/${MY_P}.tgz"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="BSD"
IUSE="bzip2 gmp ssl threads zlib"

S="${WORKDIR}/${MY_P}"

RDEPEND="bzip2? ( >=app-arch/bzip2-1.0.5 )
	zlib? ( >=sys-libs/zlib-1.2.3 )
	gmp? ( >=dev-libs/gmp-4.2.2 )
	ssl? ( >=dev-libs/openssl-0.9.8g )"

# configure.pl requires Getopt::Long, File::Spec, and File::Copy;
# all seem included in dev-lang/perl ATM.
DEPEND="${RDEPEND}
	dev-lang/perl"

src_compile() {
	# Modules that should work under any semi-recent Unix
	local modules="alloc_mmap,egd,fd_unix,posix_rt"
	local disable_modules="proc_walk,unix_procs,cpu_counter"

	if useq bzip2; then modules="${modules},bzip2"; fi
	if useq zlib; then modules="${modules},zlib"; fi
	if useq gmp; then modules="${modules},gnump"; fi
	if useq ssl; then modules="${modules},openssl"; fi
	if useq threads; then modules="${modules},pthreads"; else
		disable_modules="${disable_modules},pthreads"
	fi

	# This is also supported on i586+ - hope this is correct.
	# documention says sparc though not enables because of
	# http://bugs.gentoo.org/show_bug.cgi?id=71760#c11

	# If we have assembly code for this machine, use it
	if [ "${ARCH}" = "x86" ]; then
		modules="${modules},mp_ia32,alg_ia32"
		#below is untested.
		#modules="${modules},mp_ia32,alg_ia32,mulop_ia32,serpent_ia32,ia32_eng,md4_ia32,md5_ia32,sha1_ia32,asm_ia32"
	elif [ "${ARCH}" = "amd64" ]; then
		modules="${modules},mp_amd64"
		# monty_amd64 and mulop_amd64 had compile failures 20090103 Botan-1.8
		#disable_modules="${disable_modules},monty_generic,mulop_generic"
		#modules="${modules},monty_amd64,mp_amd64,mulop_amd64"
	elif [ "${ARCH}" = "alpha" -o "${ARCH}" = "ia64" -o \
		"${ARCH}" = "ppc64" -o "${PROFILE_ARCH}" = "mips64"  ]; then
		modules="${modules},mp_asm64"
	fi

	# Enable v9 instructions for sparc64
	if [ "${PROFILE_ARCH}" = "sparc64" ]; then
		CHOSTARCH="sparc32-v9"
	else
		CHOSTARCH="$(echo ${CHOST} | cut -d - -f 1)"
	fi

	cd "${S}"
	elog "Enabling modules: " ${modules}
	elog "Disabling modules: " ${disable_modules}

	# FIXME: We might actually be on *BSD or OS X...
	./configure.pl \
		--prefix="${D}"/usr \
		--libdir=/$(get_libdir) \
		--docdir=/share/doc/ \
		--cc=gcc \
		--os=linux \
		--cpu=${CHOSTARCH} \
		--with-endian="$(tc-endian)" \
		--with-tr1=system \
		--enable-modules=${modules} \
		--disable-modules=${disable_modules} \
		|| die "configure.pl failed"
	emake CXX="$(tc-getCXX)" AR="$(tc-getAR) crs" \
		"LIB_OPT=${CXXFLAGS}" "MACH_OPT=" || die "emake failed"
}

src_test() {
	chmod -R ugo+rX "${S}"
	emake CXX="$(tc-getCXX)" check || die "emake check failed"
	env LD_LIBRARY_PATH="${S}" ./check --validate || die "validation tests failed"
}

src_install() {
	make install || die "make install failed"
	sed -i -e "s:${D}::g" \
		"${D}"/usr/bin/botan-config \
		"${D}"/usr/$(get_libdir)/pkgconfig/botan-1.8.pc || die 'bad sed'
	mv "${D}"/usr/share/doc/Botan-${PV} "${D}"/usr/share/doc/${PF} || \
		die 'could not rename directory'
}
