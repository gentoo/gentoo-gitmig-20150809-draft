# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/flinker/flinker-1.72.ebuild,v 1.2 2004/04/19 12:12:56 wolf31o2 Exp $

inherit gcc

DESCRIPTION="GBA cart writing utility by Jeff Frohwein"
HOMEPAGE="http://www.devrs.com/gba/software.php#misc"
SRC_URI="http://www.devrs.com/gba/files/flgba.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE=""

S=${WORKDIR}

src_compile() {
	$(gcc-getCC) -o FLinker ${CFLAGS} fl.c || die
}

src_install() {
	dobin FLinker || die
	dodoc readme
}
