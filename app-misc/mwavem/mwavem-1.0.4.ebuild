# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mwavem/mwavem-1.0.4.ebuild,v 1.1 2004/01/12 23:04:47 nerdboy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="User level application for IBM Mwave modem"
HOMEPAGE="http://oss.software.ibm.com/acpmodem/"
SRC_URI="ftp://www-126.ibm.com/pub/acpmodem/1.0.4/${P}.tar.gz"
IUSE="X"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	X? ( virtual/x11 )"

src_compile() {
	epatch ${FILESDIR}/${P}-gentoo.diff

	# The driver is no longer built by default.
	econf || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	exeinto /usr/sbin
	doexe ${FILESDIR}/mwave-dev-handler

	insinto /etc/devfs.d
	newins ${FILESDIR}/mwave.devfs mwave

	insinto /etc/modules.d
	newins ${FILESDIR}/mwave.modules mwave

	dodoc AUTHORS COPYING ChangeLog FAQ INSTALL NEWS README \
		 README.devfs THANKS
	docinto doc
	dodoc doc/mwave.sgml doc/mwave.txt
	dohtml doc/mwave.html
}

pkg_postinst() {
	# Below is to get /etc/modules.d/mwave loaded into /etc/modules.conf
	if [ "${ROOT}" = "/" ]
	then
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
	fi
	ewarn "If updating from mwavem-1.0.2, you should remove the line:"
	ewarn "'alias char-major-10-219 mwave' from the file"
	ewarn "/etc/modules.d/aliases.  The line is now contained in the file"
	ewarn "/etc/modules.d/mwave"
	einfo
	einfo "The MWave Modem device requires the proper entries in /dev."
	einfo
	einfo "If you are using devfs, the following entries are in the file"
	einfo "/etc/devfs.d/mwave, so you just need to restart devfsd."
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
