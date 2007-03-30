# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fapg/fapg-0.38.ebuild,v 1.1 2007/03/30 03:15:02 beandog Exp $

inherit toolchain-funcs

DESCRIPTION="Fast Audio Playlist Generator"
HOMEPAGE="http://royale.zerezo.com/fapg/"
SRC_URI="http://royale.zerezo.com/fapg/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

src_compile() {
	echo "$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o fapg fapg.c"
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o fapg fapg.c || die "build failed"
}

src_install() {
	dobin fapg
	dodoc CHANGELOG README
	doman fapg.1
}
