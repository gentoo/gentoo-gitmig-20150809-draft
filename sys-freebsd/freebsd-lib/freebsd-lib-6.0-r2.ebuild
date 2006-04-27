# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-lib/freebsd-lib-6.0-r2.ebuild,v 1.4 2006/04/27 16:22:13 flameeyes Exp $

inherit bsdmk freebsd flag-o-matic toolchain-funcs

DESCRIPTION="FreeBSD's base system libraries"
SLOT="6.0"
KEYWORDS="~x86-fbsd"

IUSE="atm bluetooth ssl ipv6 kerberos nis gpib"

# Crypto is needed to have an internal OpenSSL header
# sys is needed for libalias, probably we can just extract that instead of
# extracting the whole tarball
SRC_URI="mirror://gentoo/${LIB}.tar.bz2
		mirror://gentoo/${CONTRIB}.tar.bz2
		mirror://gentoo/${CRYPTO}.tar.bz2
		mirror://gentoo/${LIBEXEC}.tar.bz2
		mirror://gentoo/${ETC}.tar.bz2
		mirror://gentoo/${INCLUDE}.tar.bz2
		nis? ( mirror://gentoo/${USBIN}.tar.bz2 )
		!kernel_FreeBSD? (
			mirror://gentoo/${SYS}.tar.bz2 )"

RDEPEND="ssl? ( dev-libs/openssl )
	kerberos? ( virtual/krb5 )
	!sys-freebsd/freebsd-headers"
DEPEND="${RDEPEND}
	>=sys-devel/flex-2.5.31-r2
	=sys-freebsd/freebsd-mk-defs-${RV}*
	=sys-freebsd/freebsd-sources-${RV}*"

if [[ ${CATEGORY/cross-} == {CATEGORY} ]]; then
	PROVIDE="virtual/libc
		virtual/os-headers"
fi

S="${WORKDIR}/lib"

export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} && ${CATEGORY/cross-} != ${CATEGORY} ]]; then
	export CTARGET=${CATEGORY/cross-}
fi

pkg_setup() {
	[[ -c /dev/zero ]] || \
		die "You forgot to mount /dev; the compiled libc would break."

	if ! use ssl && use kerberos; then
		eerror "If you want kerberos support you need to enable ssl support, too."
	fi

	use atm || mymakeopts="${mymakeopts} NO_ATM= "
	use bluetooth || mymakeopts="${mymakeopts} NO_BLUETOOTH= "
	use ssl || mymakeopts="${mymakeopts} NO_OPENSSL= NO_CRYPT= "
	use ipv6 || mymakeopts="${mymakeopts} NO_INET6= "
	use kerberos || mymakeopts="${mymakeopts} NO_KERBEROS= "
	use nis || mymakeopts="${mymakeopts} NO_NIS= "
	use gpib || mymakeopts="${mymakeopts} NO_GPIB= "

	mymakeopts="${mymakeopts} NO_OPENSSH= NO_BIND= NO_SENDMAIL= "

	replace-flags "-O?" -"O1"

	if [[ ${CTARGET} != ${CHOST} ]]; then
		mymakeopts="${mymakeopts} MACHINE=$(tc-arch-kernel ${CTARGET})"
		mymakeopts="${mymakeopts} MACHINE_ARCH=$(tc-arch-kernel ${CTARGET})"
	fi
}

PATCHES="${FILESDIR}/${PN}-bsdxml.patch
	${FILESDIR}/${PN}-fixmp.patch
	${FILESDIR}/${PN}-${RV}-pmc.patch
	${FILESDIR}/${PN}-${RV}-gccfloat.patch
	${FILESDIR}/${PN}-${RV}-flex-2.5.31.patch
	${FILESDIR}/${PN}-${RV}-binutils-asm.patch"

# Here we disable and remove source which we don't need or want
# In order:
# - ncurses stuff
# - archiving libraries (have their own ebuild)
# - sendmail libraries (they are installed by sendmail)
# - SNMP library and dependency (have their own ebuilds)
#
# The rest are libraries we already have somewhere else because
# they are contribution.
# Note: libtelnet is an internal lib used by telnet and telnetd programs
# as it's not used in freebsd-lib package itself, it's pointless building
# it here.
REMOVE_SUBDIRS="libncurses libform libmenu libpanel \
	libz libbz2 libarchive \
	libsm libsmdb libsmutil \
	libbegemot libbsnmp \
	libsmb libpam libpcap bind libwrap libmagic \
	libcom_err libtelnet"

src_unpack() {
	freebsd_src_unpack

	if [[ ${CTARGET} == ${CHOST} ]]; then
		ln -s "/usr/src/sys-${RV}" "${WORKDIR}/sys"
	else
		sed -i -e 's:/usr/include:/usr/'${CTARGET}'/usr/include:g' \
			"${S}/libc/"{yp,rpc}"/Makefile.inc"
	fi

	[[ -n $(install --version 2> /dev/null | grep GNU) ]] && \
		sed -i -e 's:${INSTALL} -C:${INSTALL}:' "${WORKDIR}/include/Makefile"
}

src_compile() {
	cd "${WORKDIR}/include"
	$(freebsd_get_bmake) CC=$(tc-getCC) || die "make include failed"

	use _E_CROSS_HEADERS_ONLY && return 0

	if [[ ${CTARGET} != ${CHOST} ]]; then
		export YACC='yacc -by'
		CHOST=${CTARGET} tc-export CC LD CXX

		local machine
		machine=$(tc-arch-kernel ${CTARGET})

		local csudir
		if [[ -d "${S}/csu/${machine}-elf" ]]; then
			csudir="${S}/csu/${machine}-elf"
		else
			csudir="${S}/csu/${machine}"
		fi
		cd "${csudir}"
		$(freebsd_get_bmake) ${mymakeopts} || die "make csu failed"

		append-flags "-isystem /usr/${CTARGET}/usr/include"
		append-flags "-B ${csudir}"
		append-ldflags "-B ${csudir}"
		cd "${S}/libc"
		$(freebsd_get_bmake) ${mymakeopts} || die "make libc failed"

		append-flags "-isystem ${WORKDIR}/lib/msun/${machine/i386/i387}"
		cd "${S}/msun"
		$(freebsd_get_bmake) ${mymakeopts} || die "make libc failed"
	else
		cd "${S}"
		freebsd_src_compile
	fi
}

src_install() {
	cd "${WORKDIR}/include"

	[[ ${CTARGET} == ${CHOST} ]] \
		&& INCLUDEDIR="/usr/include" \
		|| INCLUDEDIR="/usr/${CTARGET}/usr/include"

	einfo "Installing for ${CTARGET} in ${CHOST}.."

	dodir "${INCLUDEDIR}"
	$(freebsd_get_bmake) installincludes \
		MACHINE=$(tc-arch-kernel) \
		DESTDIR="${D}" INCLUDEDIR="${INCLUDEDIR}" || die "Install failed"

	# Install math.h when crosscompiling, at this point
	if [[ ${CHOST} != ${CTARGET} ]]; then
		insinto "/usr/${CTARGET}/usr/include"
		doins "${S}/msun/src/math.h"
	fi

	use _E_CROSS_HEADERS_ONLY && return 0

	if [[ ${CTARGET} != ${CHOST} ]]; then
		local csudir
		if [[ -d "${S}/csu/$(tc-arch-kernel ${CTARGET})-elf" ]]; then
			csudir="${S}/csu/$(tc-arch-kernel ${CTARGET})-elf"
		else
			csudir="${S}/csu/$(tc-arch-kernel ${CTARGET})"
		fi
		cd "${csudir}"
		$(freebsd_get_bmake) ${mymakeopts} DESTDIR="${D}" install \
			FILESDIR="/usr/${CTARGET}/usr/lib" || die "Install csu failed"

		cd "${S}/libc"
		$(freebsd_get_bmake) ${mymakeopts} DESTDIR="${D}" install NO_MAN= \
			SHLIBDIR="/usr/${CTARGET}/lib" LIBDIR="/usr/${CTARGET}/usr/lib" || die "Install failed"

		cd "${S}/msun"
		$(freebsd_get_bmake) ${mymakeopts} DESTDIR="${D}" install NO_MAN= \
			INCLUDEDIR="/usr/${CTARGET}/usr/include" \
			SHLIBDIR="/usr/${CTARGET}/lib" LIBDIR="/usr/${CTARGET}/usr/lib" || die "Install failed"

		dosym "usr/include" "/usr/${CTARGET}/sys-include"
	else
		cd "${S}"
		mkinstall || die "Install failed"
	fi

	# Don't install the rest of the configuration files if crosscompiling
	[[ ${CTARGET} != ${CHOST} ]] && return 0

	# install libstand files
	dodir /usr/include/libstand
	insinto /usr/include/libstand
	doins ${S}/libstand/*.h

	cd ${WORKDIR}/etc/
	insinto /etc
	doins auth.conf nls.alias mac.conf netconfig

	# Install ttys file
	doins "etc.$(tc-arch-kernel)"/*
}

