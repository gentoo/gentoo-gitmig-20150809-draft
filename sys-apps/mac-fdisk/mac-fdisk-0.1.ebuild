# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mac-fdisk/mac-fdisk-0.1.ebuild,v 1.15 2003/12/17 04:00:15 brad_mssw Exp $

S=${WORKDIR}/${P}
DEBRV=8
DESCRIPTION="Mac/PowerMac disk partitinoing utility"
SRC_URI="http://http.us.debian.org/debian/pool/main/m/mac-fdisk/${PN}_${PV}.orig.tar.gz
	http://http.us.debian.org/debian/pool/main/m/mac-fdisk/${PN}_${PV}-${DEBRV}.diff.gz"
HOMEPAGE="ftp://ftp.mklinux.apple.com/pub/Other_Tools/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc -x86 -amd64 -arm -alpha -hppa -mips -sparc ppc64"
DEPEND="virtual/glibc"

src_unpack() {
	cd ${WORKDIR}
	unpack mac-fdisk_${PV}.orig.tar.gz
	mv mac-fdisk-${PV}.orig ${P}
	cd ${S}
	cat ${DISTDIR}/mac-fdisk_${PV}-${DEBRV}.diff.gz | gzip -dc | patch -p1 || die
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

	dosbin mac-fdisk
	dosbin pmac-fdisk

	into /usr

	doman mac-fdisk.8
	doman pmac-fdisk.8
	dodoc README
	dodoc HISTORY
}
