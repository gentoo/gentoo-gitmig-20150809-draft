# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/watchfolder/watchfolder-0.3.3.ebuild,v 1.2 2006/02/15 21:43:32 deltacow Exp $

DESCRIPTION="Watches directories and processes files, similar to the watchfolder option of Acrobat Distiller."
HOMEPAGE="http://freshmeat.net/projects/watchd/"
SRC_URI="http://dstunrea.sdf-eu.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=""

S="${WORKDIR}/${P/folder/d}"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i "3s/OPT=/OPT=${CFLAGS} /" Makefile
}

src_install() {
	dobin watchd
	insinto /etc
	doins watchd.conf
	dodoc README doc/*
}
