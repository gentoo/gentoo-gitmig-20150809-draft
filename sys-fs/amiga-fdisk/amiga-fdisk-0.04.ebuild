# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/amiga-fdisk/amiga-fdisk-0.04.ebuild,v 1.2 2004/06/25 03:17:51 agriffis Exp $

DESCRIPTION="Amiga disklabel partitioning utility"
HOMEPAGE="http://www.freiburg.linux.de/~stepan/projects/"
SRC_URI="http://www.freiburg.linux.de/~stepan/bin/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="ppc"
IUSE=""

DEPEND="sys-libs/readline
	sys-libs/libtermcap-compat"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s/-lreadline/-lreadline -ltermcap/" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin amiga-fdisk || die
	doman amiga-fdisk.8
	dodoc ChangeLog README ToDo
}
