# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/nrg2iso/nrg2iso-0.1.ebuild,v 1.1 2003/09/09 22:31:41 zul Exp $

S=${WORKDIR}/${PN}

DESCRIPTION="Converts nrg CD-images to iso"
SRC_URI="http://gregory.kokanosky.free.fr/v4/linux/${PN}.tgz"
HOMEPAGE="http://gregory.kokanosky.free.fr/v4/linux/nrg2iso.en.html"


KEYWORDS="~x86 ~ppc ~sparc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND=""


src_compile() {
	${CC} ${CFLAGS} -o nrg2iso nrg2iso.c || die 
}

src_install() {
	dobin nrg2iso
}
