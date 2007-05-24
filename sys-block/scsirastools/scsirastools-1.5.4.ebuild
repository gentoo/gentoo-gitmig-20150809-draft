# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/scsirastools/scsirastools-1.5.4.ebuild,v 1.1 2007/05/24 07:29:46 robbat2 Exp $

inherit autotools

DESCRIPTION="Serviceability for SCSI Disks and Arrays"
HOMEPAGE="http://scsirastools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND="virtual/libc
		sys-apps/rescan-scsi-bus
		sys-apps/sg3_utils"
#RDEPEND=""

src_unpack() {
	unpack ${A}
	# this builds a really old mdadm
	sed -i.orig \
		-e '/^SUBDIRS/s,mdadm.d,,' \
		-e '/^SUBDIRS/s,files,,' \
		${S}/Makefile.am || die "sed Makefile.am failed"
	cd ${S}
	eautoreconf
	# i386 ELF binaries in tarball = bad
	rm -f ${S}/files/alarms*

	# Fix up /sbin instances to be /usr/sbin instead	
	for i in src/sgraidmon.c src/sgdiskmon.c ; do
		sed -i ${S}/${i} \
			-e '/evtcmd\[\].*\"\/sbin\//s,/sbin/,/usr/sbin/,' \
			|| die "Failed to set /sbin in sources"
	done
}

src_compile() {
	econf --sbindir=/usr/sbin \
		|| die "econf failed"
	emake \
		|| die "emake failed"
}

src_install() {
	into /usr
	docdir="/usr/share/doc/${PF}/"
	emake install DESTDIR="${D}" datato="${D}${docdir}" \
		|| "emake install failed"
	dosbin files/sgevt
	dosbin files/mdevt
	# unneeded files
	rm ${D}${docdir}/{SCSIRAS,COPYING}
	# install modepage files
	insinto /usr/share/${PN}
	doins files/*.mdf
	# new docs
	dodoc ChangeLog AUTHORS TODO
	# ensure that other docs from the emake install are compressed too.
	prepalldocs
}
