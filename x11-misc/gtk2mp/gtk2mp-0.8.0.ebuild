# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gtk2mp/gtk2mp-0.8.0.ebuild,v 1.4 2004/10/27 09:16:47 slarti Exp $

DESCRIPTION="A GTK2 frontend to Music Player Daemon (MPD), which allows remote access for playing music (MP3's, Ogg's, and Flac's) and managing playlists."
SRC_URI="http://www.moviegalaxy.com.ar/gtk2mp/${P}.tar.gz"
HOMEPAGE="http://www.moviegalaxy.com.ar/gtk2mp/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"

IUSE=""

DEPEND=">=x11-libs/gtk+-2.0"

src_install() {
	einstall || die
	dodoc TODO
}
