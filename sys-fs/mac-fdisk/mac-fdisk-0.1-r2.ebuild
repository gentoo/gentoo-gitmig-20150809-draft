# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mac-fdisk/mac-fdisk-0.1-r2.ebuild,v 1.9 2006/08/08 23:47:45 wormo Exp $

inherit eutils

DEBRV=10
DESCRIPTION="Mac/PowerMac disk partitioning utility"
HOMEPAGE="ftp://ftp.mklinux.apple.com/pub/Other_Tools/"
SRC_URI="http://http.us.debian.org/debian/pool/main/m/mac-fdisk/${PN}_${PV}.orig.tar.gz
	http://http.us.debian.org/debian/pool/main/m/mac-fdisk/${PN}_${PV}-${DEBRV}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ppc ppc64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack mac-fdisk_${PV}.orig.tar.gz
	mv mac-fdisk-${PV}.orig ${P}
	cd ${S}
	epatch ${DISTDIR}/mac-fdisk_${PV}-${DEBRV}.diff.gz

	# Hard code 2.4 headers in mac-fdisk itself - if no maintainer is found, macfdisk should
	# be deprecated in favor or parted

	use ppc && epatch ${FILESDIR}/mac-fdisk-ppc.patch
	use ppc64 && epatch ${FILESDIR}/mac-fdisk-ppc64.patch

	# this can be applied on ppc32 too:
	use ppc64 && epatch ${FILESDIR}/mac-fdisk-ppc64-1.patch
}

src_compile() {
	emake || die
}

src_install() {
	mv mac-fdisk.8.in mac-fdisk.8 || die
	mv pmac-fdisk.8.in pmac-fdisk.8 || die
	mv pdisk mac-fdisk || die
	mv fdisk pmac-fdisk || die

	into /
	dosbin mac-fdisk pmac-fdisk || die

	into /usr
	doman mac-fdisk.8 pmac-fdisk.8
	dodoc README HISTORY
}
