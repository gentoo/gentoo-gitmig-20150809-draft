# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fapg/fapg-0.22.ebuild,v 1.2 2004/08/28 23:06:11 dholm Exp $

DESCRIPTION="Fast Audio Playlist Generator"
HOMEPAGE="http://royale.zerezo.com/fapg/"
SRC_URI="http://royale.zerezo.com/fapg/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="virtual/libc"

src_compile() {
	emake || die
}

src_install() {
	dobin fapg
	dodoc CHANGELOG COPYING README
	doman fapg.1
}
