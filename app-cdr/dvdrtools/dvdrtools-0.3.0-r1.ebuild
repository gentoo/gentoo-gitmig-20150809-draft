# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/dvdrtools/dvdrtools-0.3.0-r1.ebuild,v 1.2 2006/02/23 21:28:59 corsair Exp $

inherit eutils gnuconfig

DESCRIPTION="A fork of cdrtools, including DVD support."
HOMEPAGE="http://www.arklinux.org/projects/dvdrtools"
SRC_URI="http://www.arklinux.org/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="encode"

DEPEND="virtual/libc
	!app-cdr/cdrtools"
RDEPEND="encode? ( media-video/transcode )"
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

	make DESTDIR=${D} install || die "make install failed"

	#dobin cdda2wav/cdda2wav
	#dobin cdrecord/dvdrecord
	#dobin mkisofs/mkisofs
	#dobin readcd/readcd
	dosym /usr/bin/dvdrecord /usr/bin/cdrecord

	#cd mkisofs/diag
	#dobin devdump isodump isoinfo isovfy

	cd ${S}
	insinto /etc/default
	install dvdrecord/cdrecord.dfl ${D}/etc/cdrecord.conf

	cd ${S}
	dolib.a {libdeflt,librscg,libscg,libschily}/*.a

	cd ${S}
	insinto /usr/include/scsilib
	doins include/*.h
	insinto /usr/include/scsilib/scg
	doins libscg/scg/*.h

	cd ${S}
	dodoc COPYING AUTHORS ChangeLog NEWS README
	doman */*.1
	doman */*.8

	#cd ${S}/doc
	#docinto print
	#dodoc *.ps
}
