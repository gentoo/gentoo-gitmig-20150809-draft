# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/amiga-fdisk/amiga-fdisk-0.04.ebuild,v 1.4 2004/01/17 07:39:18 darkspecter Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Amiga disklabel partitioning utility."
SRC_URI="http://www.freiburg.linux.de/~stepan/bin/${P}.tar.gz"
HOMEPAGE="http://www.freiburg.linux.de/~stepan/projects/"
LICENSE="LGPL-2"
DEPEND="sys-libs/readline
	sys-libs/libtermcap-compat"

IUSE=""
SLOT="0"
KEYWORDS="ppc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s/-lreadline/-lreadline -ltermcap/" Makefile
}

src_compile() {
	emake || die
}

src_install () {
	dobin amiga-fdisk
	doman amiga-fdisk.8

	dodoc ChangeLog COPYING README ToDo
}
