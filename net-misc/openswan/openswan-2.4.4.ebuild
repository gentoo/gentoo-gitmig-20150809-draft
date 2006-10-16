# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openswan/openswan-2.4.4.ebuild,v 1.3 2006/10/16 02:46:58 dsd Exp $

inherit eutils linux-info

MY_P=${P/_p/_kb}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Open Source implementation of IPsec for the Linux operating system (was SuperFreeS/WAN)."
HOMEPAGE="http://www.openswan.org/"
SRC_URI="http://www.openswan.org/download/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86 amd64 ~ppc"
IUSE=""

DEPEND="!net-misc/strongswan
	virtual/libc
	virtual/linux-sources
	>=dev-libs/gmp-3.1.1
	net-dns/host
	sys-apps/iproute2"
RDEPEND=""

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is 2 6; then
		einfo "This ebuild will set ${P} to use 2.6 native IPsec (KAME)."
		einfo "KLIPS will not be compiled/installed."
		export MYMAKE="programs"

	elif kernel_is 2 4; then
		if ! [ -d /usr/src/linux/net/ipsec ]; then
			eerror "You need to have an IPsec enabled 2.4.x kernel."
			eerror "Ensure you have one running and make a symlink to it in /usr/src/linux"
			die
		fi

		einfo "Using patched-in IPsec code for kernel 2.4"
		einfo "Your kernel only supports KLIPS for kernel level IPsec."
		export MYMAKE="confcheck programs"

	else
		die "Unrecognised kernel version"
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch

	# GCC4 compile fix
	sed -i -e '/LIST_INSERT_HEAD/a ;' programs/pluto/server.c
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

	dosym /etc/ipsec/ipsec.d /etc/ipsec.d

	exeinto /etc/init.d/
	doexe ${FILESDIR}/ipsec
}
