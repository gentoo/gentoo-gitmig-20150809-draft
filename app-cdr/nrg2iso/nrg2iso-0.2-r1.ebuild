# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/nrg2iso/nrg2iso-0.2-r1.ebuild,v 1.2 2004/06/06 15:26:22 dragonheart Exp $

inherit gcc flag-o-matic eutils

DESCRIPTION="Converts nrg CD-images to iso"
HOMEPAGE="http://gregory.kokanosky.free.fr/v4/linux/nrg2iso.en.html"
SRC_URI="http://gregory.kokanosky.free.fr/v4/linux/${PN}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-lfs.patch
}

src_compile() {
	append-lfs-flags
	$(gcc-getCC) ${CFLAGS} -o nrg2iso nrg2iso.c || die "failed to compile"
}

src_install() {
	dobin nrg2iso || die
}
