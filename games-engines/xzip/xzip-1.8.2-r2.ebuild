# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/xzip/xzip-1.8.2-r2.ebuild,v 1.3 2004/03/02 14:18:47 vapier Exp $

inherit games eutils

DESCRIPTION="X interface to Z-code based text games"
HOMEPAGE="http://www.eblong.com/zarf/xzip.html"
SRC_URI="http://www.eblong.com/zarf/ftp/xzip182.tar.Z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="virtual/x11"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/xzip

src_unpack() {
	unpack xzip182.tar.Z
	cd ${S}
	epatch ${FILESDIR}/xzip-182-makefile.diff
	sed -i \
		-e "s/-O/${CFLAGS}/" Makefile \
		|| die "sed Makefile failed"
}

src_install() {
	dogamesbin xzip || die
	dodoc README
	doman xzip.1
	prepgamesdirs
}
