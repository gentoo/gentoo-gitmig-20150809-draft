# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ncmpc/ncmpc-0.10.1.ebuild,v 1.6 2005/02/10 23:49:25 axxo Exp $

DESCRIPTION="A ncurses client for the Music Player Daemon (MPD)"
HOMEPAGE="http://www.musicpd.org/?page=ncmpc"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.gz"
LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="ppc x86 ~sparc ~amd64"

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
