# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrtools-dvdr/cdrtools-dvdr-2.01_alpha04.ebuild,v 1.4 2003/06/29 16:01:56 aliz Exp $

inherit eutils

DESCRIPTION="A set of tools for CDR drives, including cdrecord.	 Includes Mandrake's DVDR patch."
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/cdrecord.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/glibc"
PROVIDE="virtual/cdrtools"

DVDR_PATCH_P=cdrtools-1.11a37-dvd.patch
SRC_URI="ftp://ftp.berlios.de/pub/cdrecord/alpha/${PN/-dvdr/}-${PV/_alpha/a}.tar.gz
	http://people.mandrakesoft.com/~warly/files/cdrtools/${DVDR_PATCH_P}.bz2"
S="${WORKDIR}/${PN/-dvdr/}-2.01"

src_unpack() {
	unpack ${PN/-dvdr/}-${PV/_alpha/a}.tar.gz || die
	unpack ${DVDR_PATCH_P}.bz2 || die

	cd ${S}
	patch -p1 < ../${DVDR_PATCH_P} || die "Patch failed."

	cd ${S}
	# Add support for 2.5 kernels
	# <azarah@gentoo.org> (05 Feb 2003)
	epatch ${FILESDIR}/${PN/-dvdr}-2.01-kernel25-support.patch || die
	
	cd ${S}/DEFAULTS
	sed -e "s:/opt/schily:/usr:g" < Defaults.linux > Defaults.linux.hacked
	mv Defaults.linux.hacked Defaults.linux
}

src_compile() {
	emake || die
}

src_install() {
	dobin cdda2wav/OBJ/*-linux-cc/cdda2wav
	dobin cdrecord/OBJ/*-linux-cc/cdrecord
	cd ${S}
	dobin mkisofs/OBJ/*-linux-cc/mkisofs
	dobin readcd/OBJ/*-linux-cc/readcd
	insinto /usr/include
	doins incs/*-linux-cc/align.h incs/*-linux-cc/avoffset.h

	cd mkisofs/diag/OBJ/*-linux-cc
	dobin devdump isodump isoinfo isovfy

	cd ${S}/libs/*-linux-cc
	dolib.a *.a

	cd  ${S}
	dodoc Changelog COPYING PORTING README* START

	cd ${S}/doc
	dodoc cdrecord-1.8.1_de-doc_0.1.tar
	docinto print
	dodoc *.ps
	newman cdda2wav.man cdda2wav.1
	newman cdrecord.man cdrecord.1
	newman readcd.man readcd.1
	newman isoinfo.man isoinfo.8
	newman mkisofs.man mkisofs.8
}
