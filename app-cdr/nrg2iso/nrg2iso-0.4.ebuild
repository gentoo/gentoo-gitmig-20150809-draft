# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/nrg2iso/nrg2iso-0.4.ebuild,v 1.1 2004/07/30 10:28:32 chrb Exp $

inherit eutils

DESCRIPTION="Converts Nero nrg CD-images to iso"
HOMEPAGE="http://gregory.kokanosky.free.fr/v4/linux/nrg2iso.en.html"
SRC_URI="http://gregory.kokanosky.free.fr/v4/linux/${PN}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	${CC} ${CFLAGS} -o nrg2iso nrg2iso.c || die "failed to compile"
}

src_install() {
	dobin nrg2iso || die
}
