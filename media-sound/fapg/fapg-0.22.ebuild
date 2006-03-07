# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fapg/fapg-0.22.ebuild,v 1.7 2006/03/07 14:37:20 flameeyes Exp $

IUSE=""

inherit toolchain-funcs

DESCRIPTION="Fast Audio Playlist Generator"
HOMEPAGE="http://royale.zerezo.com/fapg/"
SRC_URI="http://royale.zerezo.com/fapg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64 sparc ~ppc64"


src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o fapg fapg.c || die "build failed"
}

src_install() {
	dobin fapg
	dodoc CHANGELOG README
	doman fapg.1
}
