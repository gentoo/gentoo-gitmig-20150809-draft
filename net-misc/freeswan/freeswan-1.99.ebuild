# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/freeswan/freeswan-1.99.ebuild,v 1.3 2003/05/29 00:43:00 weeve Exp $

X509_PATCH=0.9.15
S=${WORKDIR}/${P}
DESCRIPTION="FreeS/WAN IPSec Userspace Utilities with X.509 Patches"
SRC_URI="ftp://ftp.xs4all.nl/pub/crypto/freeswan/${P}.tar.gz
	 http://www.strongsec.com/freeswan/x509patch-${X509_PATCH}-${P}.tar.gz"

HOMEPAGE="http://www.freeswan.org"
DEPEND="virtual/glibc
        virtual/linux-sources
	>=dev-libs/gmp-3.1.1"
LICENSE="GPL-2"
RDEPEND=""
SLOT="0"
KEYWORDS="~x86 -sparc"

pkg_setup() {
    [ -d /usr/src/linux/net/ipsec ] || {
		echo You need to have the crypto-enabled version of Gentoo Sources
		echo with a symlink to it in /usr/src/linux in order to have IPSec
		echo kernel compatibility.  Please emerge sys-kernel/crypto-sources, 
		echo compile an IPSec-enabled kernel and attempt this ebuild again.
		exit 1
	}
}

src_unpack() {
	unpack ${A}

	cd ${S}
	patch -p1 < ${FILESDIR}/freeswan-gentoo-cflags.patch || die
	sed 's:/etc/ipsec.d:/etc/ipsec/ipsec.d:g' ${WORKDIR}/x509patch-${X509_PATCH}-${P}/freeswan.diff | patch -p1 || die
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

	newdoc ${WORKDIR}/x509patch-${X509_PATCH}-${P}/README README.x509
	newdoc ${WORKDIR}/x509patch-${X509_PATCH}-${P}/CHANGES CHANGES.x509
	newdoc ${WORKDIR}/x509patch-${X509_PATCH}-${P}/ipsec.secrets.template ipsec.secrets.x509
	dodoc INSTALL COPYING CREDITS BUGS CHANGES README doc/*
	dosym /etc/ipsec/ipsec.d /etc/ipsec.d
}

