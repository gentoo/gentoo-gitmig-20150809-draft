# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/nrg2iso/nrg2iso-0.2.ebuild,v 1.1 2004/01/09 22:15:46 vapier Exp $

inherit gcc

DESCRIPTION="Converts nrg CD-images to iso"
HOMEPAGE="http://gregory.kokanosky.free.fr/v4/linux/nrg2iso.en.html"
SRC_URI="http://gregory.kokanosky.free.fr/v4/linux/${PN}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND="virtual/glibc"
RDEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	$(gcc-getCC) ${CFLAGS} -o nrg2iso nrg2iso.c || die "failed to compile"
}

src_install() {
	dobin nrg2iso
}
