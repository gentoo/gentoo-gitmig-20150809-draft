# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openswan/openswan-2.1.1.ebuild,v 1.1 2004/03/29 20:08:28 pfeifer Exp $

MY_P=${P/_p/_kb}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Open Source implementation of IPsec for the Linux operating system (was SuperFreeS/WAN)."
SRC_URI="http://www.openswan.org/code/${MY_P}.tar.gz
		mirror://gentoo/${MY_P}.tar.gz"
HOMEPAGE="http://www.openswan.org/"

DEPEND="virtual/glibc
	virtual/linux-sources
	>=dev-libs/gmp-3.1.1
	net-misc/host
	sys-apps/iproute"
RDEPEND=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -*"


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

src_install () {

	make \
		DESTDIR=${D} \
		USERCOMPILE="${CFLAGS}" \
		FINALCONFDIR=/etc/ipsec \
		INC_RCDEFAULT=/etc/init.d \
		INC_USRLOCAL=/usr \
		INC_MANDIR=share/man \
		install || die

	dodoc INSTALL COPYING CREDITS BUGS CHANGES README doc/*
	dosym /etc/ipsec/ipsec.d /etc/ipsec.d

	exeinto /etc/init.d/
	doexe ${FILESDIR}/ipsec

}
