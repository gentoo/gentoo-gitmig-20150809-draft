# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/xzip/xzip-1.8.2-r2.ebuild,v 1.2 2004/02/20 06:27:48 mr_bones_ Exp $

inherit games

S=${WORKDIR}/xzip
DESCRIPTION="X interface to Z-code based text games"
SRC_URI="http://www.eblong.com/zarf/ftp/xzip182.tar.Z"
HOMEPAGE="http://www.eblong.com/zarf/xzip.html"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="virtual/x11"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack xzip182.tar.Z
	cd ${S}
	patch -p0 < ${FILESDIR}/xzip-182-makefile.diff
	sed -i \
		-e "s/-O/${CFLAGS}/" Makefile || \
			die "sed Makefile failed"
}

src_install () {
	doman xzip.1
	dogamesbin xzip
	dodoc README
	prepgamesdirs
}
