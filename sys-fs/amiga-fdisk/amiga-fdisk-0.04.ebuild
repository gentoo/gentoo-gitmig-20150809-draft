# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/amiga-fdisk/amiga-fdisk-0.04.ebuild,v 1.3 2004/10/16 19:25:02 vapier Exp $

inherit eutils

DEB_VER=9
DEB_PATCH=${PN}_${PV}-${DEB_VER}.diff
DESCRIPTION="Amiga disklabel partitioning utility"
HOMEPAGE="http://www.freiburg.linux.de/~stepan/projects/"
SRC_URI="http://www.freiburg.linux.de/~stepan/bin/${P}.tar.gz
	mirror://debian/pool/main/a/${PN}/${DEB_PATCH}.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="ppc"
IUSE=""

DEPEND="sys-libs/readline
	sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${DEB_PATCH}
	sed -i \
		-e 's:-lreadline:-lreadline -lncurses:' \
		-e "s:-O2 -fomit-frame-pointer:${CFLAGS}:" \
		Makefile || die "sed failed"
}

src_install() {
	dobin amiga-fdisk || die
	doman amiga-fdisk.8
	dodoc ChangeLog README ToDo
}
