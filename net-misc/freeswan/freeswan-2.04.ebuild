# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/freeswan/freeswan-2.04.ebuild,v 1.2 2004/01/03 14:06:50 aliz Exp $

inherit eutils

X509_PATCH=1.4.8
S=${WORKDIR}/${P}
DESCRIPTION="FreeS/WAN IPSec Userspace Utilities with X.509 Patches"
SRC_URI="ftp://ftp.xs4all.nl/pub/crypto/freeswan/${P}.tar.gz
	 http://www.strongsec.com/freeswan/x509-${X509_PATCH}-${P}.tar.gz"

HOMEPAGE="http://www.freeswan.org"
DEPEND="virtual/glibc
	virtual/linux-sources
	>=dev-libs/gmp-3.1.1
	net-misc/host
	sys-apps/iproute"
LICENSE="GPL-2"
RDEPEND=""
SLOT="0"
KEYWORDS="~x86 -sparc"

pkg_setup() {
	[ -d /usr/src/linux/net/ipsec ] || {
		echo You need to have the crypto-enabled version of Gentoo Sources
		echo with a symlink to it in /usr/src/linux in order to have IPSec
		echo kernel compatibility.

		exit 1
	}
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	cp ${WORKDIR}/x509-${X509_PATCH}\-${P}/freeswan.diff \
	   ${WORKDIR}/x509-${X509_PATCH}\-${P}/freeswan.diff.old
	sed 's:/etc/ipsec.d:/etc/ipsec/ipsec.d:g' \
	    ${WORKDIR}/x509-${X509_PATCH}-${P}/freeswan.diff.old > \
	    ${WORKDIR}/x509-${X509_PATCH}-${P}/freeswan.diff
	epatch ${WORKDIR}/x509-${X509_PATCH}-${P}/freeswan.diff
}

src_compile() {

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

	newdoc ${WORKDIR}/x509-${X509_PATCH}-${P}/README README.x509
	newdoc ${WORKDIR}/x509-${X509_PATCH}-${P}/CHANGES CHANGES.x509
	newdoc ${WORKDIR}/x509-${X509_PATCH}-${P}/ipsec.secrets.template ipsec.secrets.x509
	dodoc INSTALL COPYING CREDITS BUGS CHANGES README doc/*
	dosym /etc/ipsec/ipsec.d /etc/ipsec.d
	dosym /etc/ipsec/ipsec.conf /etc/ipsec.conf

	exeinto /etc/init.d/
	doexe ${FILESDIR}/ipsec
}

