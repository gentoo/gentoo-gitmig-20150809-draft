# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fapg/fapg-0.22.ebuild,v 1.6 2004/10/19 07:30:32 eradicator Exp $

IUSE=""

inherit toolchain-funcs

DESCRIPTION="Fast Audio Playlist Generator"
HOMEPAGE="http://royale.zerezo.com/fapg/"
SRC_URI="http://royale.zerezo.com/fapg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64 sparc ~ppc64"

DEPEND="virtual/libc"

src_compile() {
	# emake || die
	$(tc-getCC) ${CFLAGS} -o fapg fapg.c || die
}

src_install() {
	dobin fapg
	dodoc CHANGELOG README
	doman fapg.1
}
