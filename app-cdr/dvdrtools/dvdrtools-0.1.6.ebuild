# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/dvdrtools/dvdrtools-0.1.6.ebuild,v 1.5 2004/10/31 02:45:11 pylon Exp $

inherit eutils gcc gnuconfig

DESCRIPTION="A fork of cdrtools, including DVD support."
HOMEPAGE="http://www.nongnu.org/dvdrtools/"
SRC_URI="http://files.generaal.net/dvdrtools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND="virtual/libc
	!app-cdr/cdrtools"
PROVIDE="virtual/cdrtools"

src_unpack() {
	unpack ${A}

	cd ${S}/librscg
	sed -i -e "s:/opt/schily:/usr:g" scsi-remote.c
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	cd ${S}
	dobin cdda2wav/cdda2wav
	dobin cdrecord/dvdrecord
	dobin mkisofs/mkisofs
	dobin readcd/readcd
	dosym /usr/bin/dvdrecord /usr/bin/cdrecord

	cd mkisofs/diag
	dobin devdump isodump isoinfo isovfy

	cd ${S}
	insinto /etc/default
	install rscsi/rscsi.dfl ${D}/etc/default/rscsi
	install cdrecord/cdrecord.dfl ${D}/etc/cdrecord.conf

	cd ${S}
	dolib.a {libdeflt,libfile,libhfs_iso,librscg,libscg,libschily,libunls}/*.a

	cd ${S}
	insinto /usr/include/scsilib
	doins include/*.h
	insinto /usr/include/scsilib/scg
	doins libscg/scg/*.h

	cd ${S}
	dodoc COPYING AUTHORS Changelog NEWS README
	doman */*.1
	doman */*.8

	cd ${S}/doc
	docinto print
	dodoc *.ps
}

pkg_postinst() {
	einfo "This version of dvdrtools does not support ATAPI writing, you must use SCSI emulation."
}
