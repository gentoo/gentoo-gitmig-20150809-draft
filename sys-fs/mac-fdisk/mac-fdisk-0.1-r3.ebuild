# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mac-fdisk/mac-fdisk-0.1-r3.ebuild,v 1.1 2004/11/03 15:58:06 corsair Exp $

inherit eutils

DEBRV=11
DESCRIPTION="Mac/PowerMac disk partitioning utility"
HOMEPAGE="ftp://ftp.mklinux.apple.com/pub/Other_Tools/"
SRC_URI="http://http.us.debian.org/debian/pool/main/m/mac-fdisk/${PN}_${PV}.orig.tar.gz
	http://http.us.debian.org/debian/pool/main/m/mac-fdisk/${PN}_${PV}-${DEBRV}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~ppc64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack mac-fdisk_${PV}.orig.tar.gz
	mv mac-fdisk-${PV}.orig ${P}
	cd ${S}
	cat ${DISTDIR}/mac-fdisk_${PV}-${DEBRV}.diff.gz | gzip -dc | patch -p1 || die

	use ppc64 && epatch ${FILESDIR}/mac-fdisk-0.1-r3-ppc64.patch

	cd ${WORKDIR}
	chown -R 0:0 *
	chmod -R a+r-w+X,u+w *
}

src_compile() {
	emake || die
}

src_install() {
	mv pdisk.8 pdisk.8.in
	ln mac-fdisk.8.in mac-fdisk.8 || die
	ln pmac-fdisk.8.in pmac-fdisk.8 || die
	ln pdisk mac-fdisk || die
	ln fdisk pmac-fdisk || die

	into /
	dosbin mac-fdisk pmac-fdisk || die

	into /usr
	doman mac-fdisk.8 pmac-fdisk.8
	dodoc README HISTORY
}
