# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mwavem/mwavem-1.0.2.ebuild,v 1.7 2004/01/12 23:04:47 nerdboy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="User level application for IBM Mwave modem"
HOMEPAGE="http://oss.software.ibm.com/acpmodem/"
SRC_URI="ftp://www-126.ibm.com/pub/acpmodem/${P}.tar.gz"
IUSE="X"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc
	X? ( virtual/x11 )"

src_compile() {
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff

	./configure \
		--disable-mwavedd \
		--host=${CHOST} || die "./configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install ||die

	exeinto /usr/sbin
	doexe ${FILESDIR}/mwave-dev-handler
}

pkg_postinst() {
	einfo
	einfo "To use the MWave Modem device you must setup the proper entries in /dev"
	einfo
	einfo "If you are using devfs, add the following entries to /etc/devfsd.conf:"
	einfo
	einfo "REGISTER	^misc/mwave$	EXECUTE /usr/sbin/mwave-dev-handler register"
	einfo "UNREGISTER	^misc/mwave$	EXECUTE /usr/sbin/mwave-dev-handler unregister"
	einfo
	einfo "If you are not using devfs, execute the following commands:"
	einfo
	einfo "# mkdir -p /dev/modems"
	einfo "# mknod --mode=660 /dev/modems/mwave c 10 219"
	einfo
}
