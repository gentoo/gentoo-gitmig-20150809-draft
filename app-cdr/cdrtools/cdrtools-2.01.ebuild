# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrtools/cdrtools-2.01.ebuild,v 1.1 2004/09/14 11:42:22 pylon Exp $

inherit eutils gcc gnuconfig

DESCRIPTION="A set of tools for CD recording, including cdrecord"
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/cdrecord.html"
SRC_URI="ftp://ftp.berlios.de/pub/cdrecord/${P}.tar.bz2"

LICENSE="GPL-2 freedist"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~ppc64 ~mips"
IUSE=""

DEPEND="virtual/libc"
PROVIDE="virtual/cdrtools"

S=${WORKDIR}/${PN}-2.01

src_unpack() {
	unpack ${A}
	cd ${S}

	# CAN-2004-0806 - Bug 63187
	epatch ${FILESDIR}/${PN}-2.01-scsi-remote.patch

	cd ${S}/DEFAULTS
	sed -i "s:/opt/schily:/usr:g" Defaults.linux
	sed -i "s:/usr/src/linux/include::g" Defaults.linux

	cd ${S}/librscg
	sed -i "s:/opt/schily:/usr:g" scsi-remote.c

	cd ${S}/RULES
	ln -sf i386-linux-cc.rul x86_64-linux-cc.rul
	ln -sf i386-linux-gcc.rul x86_64-linux-gcc.rul
	ln -sf ppc-linux-cc.rul ppc64-linux-cc.rul
}

src_compile() {
	gnuconfig_update

	emake CC="$(gcc-getCC) -D__attribute_const__=const" COPTX="${CFLAGS}" CPPOPTX="${CPPFLAGS}" LDOPTX="${LDFLAGS}" || die
}

src_install() {
	cd ${S}
	dobin cdda2wav/OBJ/*-linux-cc/cdda2wav
	dobin cdrecord/OBJ/*-linux-cc/cdrecord
	dobin mkisofs/OBJ/*-linux-cc/mkisofs
	dobin readcd/OBJ/*-linux-cc/readcd
	dosbin rscsi/OBJ/*-linux-cc/rscsi
	insinto /usr/include
	doins incs/*-linux-cc/align.h incs/*-linux-cc/avoffset.h incs/*-linux-cc/xconfig.h

	cd mkisofs/diag/OBJ/*-linux-cc
	dobin devdump isodump isoinfo isovfy

	cd ${S}
	insinto /etc/default
	doins rscsi/rscsi.dfl
	doins cdrecord/cdrecord.dfl

	cd ${S}/libs/*-linux-cc
	dolib.a *.a

	cd ${S}
	insinto /usr/include/scsilib
	doins include/*.h
	insinto /usr/include/scsilib/scg
	doins include/scg/*.h

	cd ${S}
	dodoc ABOUT Changelog README README.{ATAPI,audio,cdplus,cdrw,cdtext,cdclone,copy,DiskT@2,linux,linux-shm,multi,parallel,raw,rscsi,sony,verify} START
	doman */*.1
	doman */*.8

	cd ${S}/doc
	dodoc cdrecord-1.8.1_de-doc_0.1.tar
	docinto print
	dodoc *.ps
}

pkg_postinst() {
	einfo "Note the special license on cdrecord/cdrecord.c starting from line 4648."
	echo
	einfo "The command line option 'dev=ATAPI:' should be used for IDE CD writers."
}
