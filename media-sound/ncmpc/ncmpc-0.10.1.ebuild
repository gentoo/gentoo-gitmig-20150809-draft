# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ncmpc/ncmpc-0.10.1.ebuild,v 1.1 2004/06/27 06:15:22 ferringb Exp $

DESCRIPTION="A ncurses client for the Music Player Daemon (MPD)"
HOMEPAGE="http://www.musicpd.org/?page=ncmpc"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"
LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="~ppc ~x86"

RDEPEND="virtual/libc
	sys-libs/ncurses
	dev-libs/popt
	>=dev-libs/glib-2.0"
DEPEND="${RDEPEND}"

src_install() {
	make install DESTDIR=${D} docdir=/usr/share/doc/${PF} \
		|| die "install failed"
	prepalldocs
}
