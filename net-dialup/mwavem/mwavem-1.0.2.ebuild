# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/mwavem/mwavem-1.0.2.ebuild,v 1.1 2004/12/05 08:18:33 mrness Exp $

inherit eutils

DESCRIPTION="User level application for IBM Mwave modem"
HOMEPAGE="http://oss.software.ibm.com/acpmodem/"
SRC_URI="ftp://www-126.ibm.com/pub/acpmodem/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="X"

DEPEND="virtual/libc
	X? ( virtual/x11 )"

src_compile() {
	epatch ${FILESDIR}/${P}-gentoo.diff
	./configure \
		--disable-mwavedd \
		--host=${CHOST} \
		|| die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install ||die
	dosbin ${FILESDIR}/mwave-dev-handler
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
