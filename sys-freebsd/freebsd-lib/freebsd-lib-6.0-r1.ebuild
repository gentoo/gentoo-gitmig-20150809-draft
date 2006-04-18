# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-lib/freebsd-lib-6.0-r1.ebuild,v 1.2 2006/04/18 23:35:22 flameeyes Exp $

inherit bsdmk freebsd flag-o-matic toolchain-funcs

DESCRIPTION="FreeBSD's base system libraries"
SLOT="${RV}"
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
		nis? ( mirror://gentoo/${USBIN}.tar.bz2 )"

RDEPEND="ssl? ( dev-libs/openssl )
	kerberos? ( virtual/krb5 )"
DEPEND="${RDEPEND}
	>=sys-devel/flex-2.5.31-r2
	=sys-freebsd/freebsd-mk-defs-${RV}*
	=sys-freebsd/freebsd-sources-${RV}*
	=sys-freebsd/freebsd-headers-${RV}*"

PROVIDE="virtual/libc"

S="${WORKDIR}/lib"

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
	append-flags -static-libgcc
	append-ldflags -static-libgcc
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
	use _E_CROSS_HEADERS_ONLY && return 0

	freebsd_src_unpack

	ln -s "/usr/src/sys-${RV}" "${WORKDIR}/sys"
	ln -s "/usr/include" "${WORKDIR}/include"
}

portage-to-fbsd-arch() {
	case "$(tc-arch)" in
		x86) echo "i386" ;;
		*)	 echo $(tc-arch) ;;
	esac
}

src_compile() {
	use _E_CROSS_HEADERS_ONLY && return 0

	freebsd_src_compile
}

src_install() {
	use _E_CROSS_HEADERS_ONLY && return 0
	mkinstall || die "Install failed"

	# make crt1.o schg so that gcc doesn't remove it
	chflags schg ${D}/usr/lib/crt1.o

	# install libstand files
	dodir /usr/include/libstand
	insinto /usr/include/libstand
	doins ${S}/libstand/*.h

	cd ${WORKDIR}/etc/
	insinto /etc
	doins auth.conf nls.alias mac.conf netconfig

	# Install ttys file
	doins "etc.$(portage-to-fbsd-arch)"/*
}
