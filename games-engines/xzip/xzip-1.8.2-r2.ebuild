# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/xzip/xzip-1.8.2-r2.ebuild,v 1.8 2006/12/04 22:30:52 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="X interface to Z-code based text games"
HOMEPAGE="http://www.eblong.com/zarf/xzip.html"
SRC_URI="http://www.eblong.com/zarf/ftp/xzip182.tar.Z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libX11"

S=${WORKDIR}/xzip

src_unpack() {
	unpack xzip182.tar.Z
	cd "${S}"
	epatch "${FILESDIR}"/xzip-182-makefile.diff
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
