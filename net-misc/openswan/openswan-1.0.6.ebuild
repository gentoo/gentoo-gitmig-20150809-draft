# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openswan/openswan-1.0.6.ebuild,v 1.3 2004/07/23 07:33:47 pfeifer Exp $

inherit eutils

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Open Source implementation of IPsec for the Linux operating system (was SuperFreeS/WAN)."
HOMEPAGE="http://www.openswan.org/"
SRC_URI="http://www.openswan.org/code/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}.tar.gz"

DEPEND="virtual/libc
	virtual/linux-sources
	net-misc/host
	>=dev-libs/gmp-3.1.1"
LICENSE="GPL-2"
RDEPEND=""
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

pkg_setup() {
	[ -d /usr/src/linux/net/ipsec ] || {
		echo You need to have the crypto-enabled version of Gentoo Sources
		echo with a symlink to it in /usr/src/linux in order to have IPSec
		echo kernel compatibility.  Please emerge sys-kernel/crypto-sources,
		echo compile an IPSec-enabled kernel and attempt this ebuild again.
		die
	}
}

src_unpack() {
	unpack ${A}
}

src_compile() {
	cp ${S}/libdes/Makefile ${S}/libdes/Makefile.orig
	sed s:/usr/local:/usr:g < ${S}/libdes/Makefile.orig \
		> ${S}/libdes/Makefile
	cp ${S}/libdes/Makefile ${S}/libdes/Makefile.orig
	sed s:/usr/man:/usr/share/man:g < ${S}/libdes/Makefile.orig \
		> ${S}/libdes/Makefile

	make	 				   	\
		DESTDIR=${D}				\
		USERCOMPILE="${CFLAGS}"			\
		FINALCONFDIR=/etc/ipsec			\
		INC_RCDEFAULT=/etc/init.d		\
		INC_USRLOCAL=/usr			\
		INC_MANDIR=share/man			\
		confcheck programs || die
}

src_install () {

	# try make prefix=${D}/usr install

	make 						\
		DESTDIR=${D}				\
		USERCOMPILE="${CFLAGS}"			\
		FINALCONFDIR=/etc/ipsec			\
		INC_RCDEFAULT=/etc/init.d		\
		INC_USRLOCAL=/usr			\
		INC_MANDIR=share/man			\
		install || die

	dodoc INSTALL COPYING CREDITS BUGS CHANGES README doc/*
	dosym /etc/ipsec/ipsec.d /etc/ipsec.d
}

