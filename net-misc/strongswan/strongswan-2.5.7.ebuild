# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/strongswan/strongswan-2.5.7.ebuild,v 1.5 2006/05/01 23:02:52 weeve Exp $

inherit eutils

DESCRIPTION="Open Source implementation of IPsec for the Linux operating system."
HOMEPAGE="http://www.strongswan.org/"
SRC_URI="http://download.strongswan.org/${P}.tar.bz2
	mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ppc sparc x86"
IUSE="curl ldap smartcard"

DEPEND="!net-misc/openswan
	virtual/libc
	virtual/linux-sources
	curl? ( net-misc/curl )
	ldap? ( =net-nds/openldap-2* )
	smartcard? ( dev-libs/opensc )
	>=dev-libs/gmp-3.1.1
	net-dns/host
	sys-apps/iproute2"
RDEPEND=""

check_version_h() {
	if [ ! -f "${ROOT}/usr/src/linux/include/linux/version.h" ]
	then
		eerror "Please verify that your /usr/src/linux symlink is pointing"
		eerror "to your current kernel sources, and that you have a running kernel"
		die "/usr/src/linux symlink not setup!"
	fi
}

get_KV_info() {
	check_version_h

	# Get the kernel version of sources in /usr/src/linux ...
	export KV_full="$(awk '/UTS_RELEASE/ { gsub("\"", "", $3); print $3 }' \
		"${ROOT}/usr/src/linux/include/linux/version.h")"
	export KV_major="$(echo "${KV_full}" | cut -d. -f1)"
	export KV_minor="$(echo "${KV_full}" | cut -d. -f2)"
	export KV_micro="$(echo "${KV_full}" | cut -d. -f3 | sed -e 's:[^0-9].*::')"
}

is_kernel() {
	[ -z "$1" -o -z "$2" ] && return 1

	get_KV_info

	if [ "${KV_major}" -eq "$1" -a "${KV_minor}" -eq "$2" ]
	then
		return 0
	else
		return 1
	fi
}

pkg_setup() {
	get_KV_info

	einfo "Linux kernel is version ${KV_major}.${KV_minor}.${KV_micro}"

	if is_kernel 2 5
	then
	eerror "Kernel version ${KV_major}.${KV_minor}.${KV_micro} will not work with this ebuild."
	die "Please install a 2.6.x version of the Linux kernel."
	fi

	if is_kernel 2 6
	then
	einfo "This ebuild will set ${P} to use 2.6 native IPsec (KAME)."
	einfo "KLIPS will not be compiled/installed."
	export MYMAKE="programs"

	elif is_kernel 2 4
	then
		[ -d /usr/src/linux/net/ipsec ] || {
		eerror "You need to have an IPsec enabled 2.4.x kernel."
		eerror "Ensure you have one running and make a symlink to it in /usr/src/linux"
		}
	einfo "Using patched-in IPsec code for kernel 2.4"
	einfo "Your kernel only supports KLIPS for kernel level IPsec."
	export MYMAKE="confcheck programs"

	else
	eerror "Sorry, no support for your kernel version ${KV_major}.${KV_minor}.${KV_micro}."
	die "Install an IPsec enabled 2.4 or 2.6 kernel."
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	cd programs/pluto

	if use curl ; then
		ebegin "Curl support requested. Enabling curl support"
		sed -i -e 's:#LIBCURL=1:LIBCURL=1:g' Makefile || die
		eend $?
	fi

	if use ldap ; then
		ebegin "LDAP support requested. Enabling LDAPv3 support"
		sed -i -e 's:#LDAP_VERSION=3:LDAP_VERSION=3:g' Makefile || die
		eend $?
	fi

	if  use smartcard ; then
		ebegin "Smartcard support requested. Enabling opensc support"
		sed -i -e 's:#SMARTCARD=1:SMARTCARD=1:g' Makefile || die
		eend $?
	fi
}

src_compile() {
	make \
		DESTDIR=${D} \
		USERCOMPILE="${CFLAGS}" \
		FINALCONFDIR=/etc/ipsec \
		INC_RCDEFAULT=/etc/init.d \
		INC_USRLOCAL=/usr \
		INC_MANDIR=share/man \
		${MYMAKE} || die
}

src_install() {
	make \
		DESTDIR=${D} \
		USERCOMPILE="${CFLAGS}" \
		FINALCONFDIR=/etc/ipsec \
		INC_RCDEFAULT=/etc/init.d \
		INC_USRLOCAL=/usr \
		INC_MANDIR=share/man \
		install || die

	dohtml doc/*.html
	rm -f ${S}/doc/*.html
	dodoc CHANGES* CREDITS INSTALL LICENSE README* doc/*
	dosym /etc/ipsec/ipsec.d /etc/ipsec.d

	exeinto /etc/init.d/
	doexe ${FILESDIR}/ipsec
}
