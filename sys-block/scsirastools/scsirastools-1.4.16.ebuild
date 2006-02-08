# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/scsirastools/scsirastools-1.4.16.ebuild,v 1.2 2006/02/08 02:08:31 robbat2 Exp $

inherit autotools

DESCRIPTION="Serviceability for SCSI Disks and Arrays"
HOMEPAGE="http://scsirastools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/libc"
#RDEPEND=""

src_unpack() {
	unpack ${A}
	# this builds a really old mdadm
	sed -i.orig \
		-e '/^SUBDIRS/s,mdadm.d,,' \
		-e '/^SUBDIRS/s,files,,' \
		${S}/Makefile.am || die "sed Makefile.am failed"
	eautomake
}

src_compile() {
	econf --sbindir=/usr/sbin || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	docdir="/usr/share/doc/${PF}/"
	emake install DESTDIR="${D}" datato="${D}${docdir}" \
		|| "emake install failed"
	# unneeded files
	rm ${D}${docdir}/{SCSIRAS,COPYING}
	# install modepage files
	insinto /usr/share/${PN}
	doins files/*.mdf
	# new docs
	dodoc ChangeLog AUTHORS TODO
	prepalldocs
}
