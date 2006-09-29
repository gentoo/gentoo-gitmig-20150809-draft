# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audtty/audtty-0.1.5a.ebuild,v 1.1 2006/09/29 16:26:04 chainsaw Exp $

inherit autotools

IUSE=""

DESCRIPTION="Control Audacious from the command line with a friendly ncurses interface"
HOMEPAGE="http://audacious-media-player.org/Audtty"
SRC_URI="http://www.nenolod.net/audtool/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~x86 ~ppc"

DEPEND="sys-libs/ncurses
	media-sound/audacious"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog README
}
