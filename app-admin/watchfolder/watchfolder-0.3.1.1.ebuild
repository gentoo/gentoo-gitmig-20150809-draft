# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/watchfolder/watchfolder-0.3.1.1.ebuild,v 1.4 2003/09/26 20:45:47 aliz Exp $

MY_PV="${PV:0:5}_p1"

DESCRIPTION="Watches directories and processes files, similar to the watchfolder option of Acrobat Distiller."
HOMEPAGE=""
SRC_URI="http://dstunrea.sdf-eu.org/files/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=""
#RDEPEND=""
S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i "3s:OPT=:OPT=${CFLAGS} :" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin watchd
	insinto /etc
	doins watchd.conf
	dodoc README doc/*
}
