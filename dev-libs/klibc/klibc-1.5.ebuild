# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/klibc/klibc-1.5.ebuild,v 1.3 2007/10/11 08:01:25 opfer Exp $

inherit eutils linux-info multilib toolchain-funcs

export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi

DESCRIPTION="A minimal libc subset for use with initramfs."
HOMEPAGE="http://www.zytor.com/mailman/listinfo/klibc"
SRC_URI="ftp://ftp.kernel.org/pub/linux/libs/klibc/${P}.tar.bz2
	ftp://ftp.kernel.org/pub/linux/libs/klibc/Testing/${P}.tar.bz2"

LICENSE="|| ( GPL-2 LGPL-2 )"
KEYWORDS="~amd64 -mips ~ppc x86"
IUSE="debug n32"

DEPEND="dev-lang/perl
	virtual/linux-sources"
RDEPEND="dev-lang/perl"

if [[ ${CTARGET} != ${CHOST} ]] ; then
	SLOT="${CTARGET}"
else
	SLOT="0"
fi

# Klibc has no PT_GNU_STACK support, so scanning for execstacks is moot
QA_EXECSTACK="*"

guess_arch() {
	local x
	local host=$(echo "${CTARGET%%-*}" | sed -e 's/i.86/i386/' \
	                                         -e 's/sun4u/sparc64/' \
	                                         -e 's/arm.*/arm/' \
	                                         -e 's/sa110/arm/' \
	                                         -e 's/powerpc/ppc/')

	# Sort reverse so that we will get ppc64 before ppc, etc
	for x in $(ls -1 "${S}/usr/include/arch/" | sort -r) ; do
		if [[ ${host} == "${x}" ]] ; then
			echo "${x}"
			return 0
		fi
	done

	return 1
}

src_unpack() {
	unpack ${A}

	if [[ ! -d /usr/${CTARGET} ]] ; then
		echo
		eerror "It does not look like your cross-compiler is setup properly!"
		die "It does not look like your cross-compiler is setup properly!"
	fi

	einfo "CTARGET = $CTARGET"
	if ! guess_arch &>/dev/null ; then
		echo
		eerror "Could not guess klibc's ARCH from your CTARGET!"
		die "Could not guess klibc's ARCH from your CTARGET!"
	fi

	kernel_arch=$(readlink "${KV_OUT_DIR}/include/asm" | sed -e 's:asm-::' | \
	              sed -e 's/powerpc/ppc/')
	if [[ ${kernel_arch} != $(guess_arch) ]] ; then
		echo
		eerror "Your kernel sources are not configured for your chosen arch!"
		eerror "(KERNEL_ARCH=\"${kernel_arch}\", ARCH=\"$(guess_arch)\")"
		die "Your kernel sources are not configured for your chosen arch!"
	fi

	cd "${S}"

	# Symlink /usr/src/linux to ${S}/linux
	ln -snf ${KV_DIR} linux

	# Build interp.o with EXTRA_KLIBCAFLAGS (.S source)
	epatch "${FILESDIR}"/${PN}-1.4.11-interp-flags.patch

	# klibc detects mips64 systems as having 64bit userland
	# Force them to 32bit userlands instead
	if use mips ; then
		! use n32 && epatch "${FILESDIR}"/${PN}-1.4.9-mips32.patch
	fi
}

src_compile() {
	local myargs

	[[ ${KV_DIR} != "${KV_OUT_DIR}" ]] && \
		myargs="KLIBCKERNELOBJ='${KV_OUT_DIR}/' KBUILD_SRC='1'"

	use debug && myargs="${myargs} V=1"

	if tc-is-cross-compiler ; then
		einfo "ARCH = \"$(guess_arch)\""
		einfo "CROSS = \"${CTARGET}-\""
		emake KLIBCARCH=$(guess_arch) \
			CROSS_COMPILE="${CTARGET}-" \
			EXTRA_KLIBCAFLAGS="-Wa,--noexecstack" \
			EXTRA_KLIBCLDFLAGS="-z,noexecstack" \
			libdir="/usr/$(get_libdir)" \
			SHLIBDIR="/$(get_libdir)" \
			mandir="/usr/share/man" \
			INSTALLDIR="/usr/$(get_libdir)/klibc" \
			${myargs} || die "Compile failed!"
	else
		env -u ARCH \
		emake \
			EXTRA_KLIBCAFLAGS="-Wa,--noexecstack" \
			EXTRA_KLIBCLDFLAGS="-z,noexecstack" \
			libdir="/usr/$(get_libdir)" \
			SHLIBDIR="/$(get_libdir)" \
			mandir="/usr/share/man" \
			INSTALLDIR="/usr/$(get_libdir)/klibc" \
			${myargs} || die "Compile failed!"
	fi
}

src_install() {
	local myargs klibc_prefix

	[[ ${KV_DIR} != "${KV_OUT_DIR}" ]] && \
		myargs="KLIBCKERNELOBJ='${KV_OUT_DIR}/' KBUILD_SRC='1'"

	use debug && myargs="${myargs} V=1"

	if tc-is-cross-compiler ; then
		klibc_prefix=$("${S}/klcc/${CTARGET}-klcc" -print-klibc-prefix)

		make \
			EXTRA_KLIBCAFLAGS="-Wa,--noexecstack" \
			EXTRA_KLIBCLDFLAGS="-z,noexecstack" \
			INSTALLROOT="${D}" \
			KLIBCARCH=$(guess_arch) \
			CROSS_COMPILE="${CTARGET}-" \
			libdir="/usr/$(get_libdir)" \
			SHLIBDIR="/$(get_libdir)" \
			mandir="/usr/share/man" \
			INSTALLDIR="/usr/$(get_libdir)/klibc" \
			${myargs} \
			install || die "Install failed!"
	else
		klibc_prefix=$("${S}/klcc/klcc" -print-klibc-prefix)

		env -u ARCH \
		make \
			EXTRA_KLIBCAFLAGS="-Wa,--noexecstack" \
			EXTRA_KLIBCLDFLAGS="-z,noexecstack" \
			INSTALLROOT="${D}" \
			libdir="/usr/$(get_libdir)" \
			SHLIBDIR="/$(get_libdir)" \
			mandir="/usr/share/man" \
			INSTALLDIR="/usr/$(get_libdir)/klibc" \
			${myargs} \
			install || die "Install failed!"
	fi

	# klibc doesn't support prelinking, so we need to mask it
	cat > "${T}/70klibc" <<-EOF
		PRELINK_PATH_MASK="/usr/$(get_libdir)/klibc"
	EOF

	doenvd "${T}"/70klibc

	# Fix the permissions (bug #178053) on /usr/$(get_libdir)/klibc/include
	# Actually I have no idea, why the includes have those weird-ass permissions
	# on a particular system, might be due to inherited permissions from parent
	# directory

	find "${D}"/usr/$(get_libdir)/klibc/include | xargs chmod o+rX

	# Hardlinks becoming copies
	for x in gunzip zcat ; do
		rm -f "${D}/${klibc_prefix}/bin/${x}"
		dosym gzip "${klibc_prefix}/bin/${x}"
	done

	if ! tc-is-cross-compiler ; then
		cd "${S}"
		insinto /usr/share/aclocal
		doins contrib/klibc.m4

		dodoc README usr/klibc/CAVEATS usr/klibc/README
		newdoc usr/klibc/arch/README README.klibc.arch
		docinto dash; newdoc usr/dash/README.klibc README
		docinto gzip; dodoc usr/gzip/README
	fi
}
