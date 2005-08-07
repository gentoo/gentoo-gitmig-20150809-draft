# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fapg/fapg-0.30.ebuild,v 1.3 2005/08/07 13:23:10 hansmi Exp $

IUSE=""

inherit toolchain-funcs

DESCRIPTION="Fast Audio Playlist Generator"
HOMEPAGE="http://royale.zerezo.com/fapg/"
SRC_URI="http://royale.zerezo.com/fapg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc x86"

DEPEND="virtual/libc"

src_compile() {
	$(tc-getCC) ${CFLAGS} -o fapg fapg.c || die
}

src_install() {
	dobin fapg
	dodoc CHANGELOG README
	doman fapg.1
}
