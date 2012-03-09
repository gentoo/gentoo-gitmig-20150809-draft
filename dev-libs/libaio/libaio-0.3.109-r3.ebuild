# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libaio/libaio-0.3.109-r3.ebuild,v 1.1 2012/03/09 16:12:46 haubi Exp $

EAPI="3"

inherit eutils multilib toolchain-funcs

DESCRIPTION="Asynchronous input/output library that uses the kernels native interface"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/andrea/libaio/ http://lse.sourceforge.net/io/aio.html"
SRC_URI="mirror://kernel/linux/libs/aio/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

EMULTILIB_PKG="true"

src_unpack() {
	for ABI in $(get_install_abis)
	do
		mkdir -p "${WORKDIR}"/${ABI} || die
		cd "${WORKDIR}"/${ABI} || die
		unpack ${A}
	done
}

src_prepare() {
	for ABI in $(get_install_abis)
	do
		einfo "Preparing ${ABI} ABI ..."
		cd "${WORKDIR}"/${ABI}/${P} || die
		epatch "${FILESDIR}"/${PN}-0.3.109-unify-bits-endian.patch
		epatch "${FILESDIR}"/${PN}-0.3.109-generic-arch.patch
		epatch "${FILESDIR}"/${PN}-0.3.106-build.patch
		epatch "${FILESDIR}"/${PN}-0.3.107-ar-ranlib.patch
		epatch "${FILESDIR}"/${PN}-0.3.109-install.patch
		epatch "${FILESDIR}"/${PN}-0.3.109-x32.patch
		epatch "${FILESDIR}"/${PN}-0.3.109-testcase-8.patch
		sed -i \
			-e "/^libdir=/s:lib$:$(get_libdir):" \
			-e "/^prefix=/s:/usr:${EPREFIX}/usr:" \
			-e '/:=.*strip.*shell.*git/s:=.*:=:' \
			src/Makefile Makefile || die
	done
}

emake_libaio() {
	# The Makefiles need these environments, but multilib_toolchain_setup()
	# does not export anything when there is only one default abi available.
	CC="$(tc-getCC) $(get_abi_CFLAGS)" \
	AR=$(tc-getAR) \
	RANLIB=$(tc-getRANLIB) \
	emake "$@"
}

src_compile() {
	for ABI in $(get_install_abis)
	do
		einfo "Compiling ${ABI} ABI ..."
		cd "${WORKDIR}"/${ABI}/${P} || die
		emake_libaio || die
	done
}

src_test() {
	for ABI in $(get_install_abis)
	do
		einfo "Testing ${ABI} ABI ..."
		cd "${WORKDIR}"/${ABI}/${P}/harness || die
		mkdir testdir || die
		# 'make check' breaks with sandbox, 'make partcheck' works
		emake_libaio partcheck prefix="${S}/src" libdir="${S}/src" || die
	done
}

src_install() {
	for ABI in $(get_install_abis)
	do
		einfo "Installing ${ABI} ABI ..."
		cd "${WORKDIR}"/${ABI}/${P} || die

		# Don't use ED for emake, src_prepare already inserts EPREFIX in the correct
		# place
		emake_libaio install DESTDIR="${D}" || die

		if is_final_abi; then
			doman man/*
			dodoc ChangeLog TODO
		else
			# take headers from default abi only
			rm -rf "${ED}"/usr/include || die
		fi

		# move crap to / for multipath-tools #325355
		gen_usr_ldscript -a aio
	done

	if ! use static-libs ; then
		rm "${ED}"usr/lib*/*.a || die
	fi

	# remove stuff provided by man-pages now
	rm "${ED}"usr/share/man/man3/{lio_listio,aio_{cancel,error,fsync,init,read,return,suspend,write}}.*
}
