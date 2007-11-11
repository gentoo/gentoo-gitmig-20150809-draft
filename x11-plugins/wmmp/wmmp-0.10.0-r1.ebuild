# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmp/wmmp-0.10.0-r1.ebuild,v 1.4 2007/11/11 16:22:37 armin76 Exp $

MY_P=${P/wm/WM}

DESCRIPTION="A Window Maker dock app client for Music Player Daemon(media-sound/mpd)"
HOMEPAGE="http://www.musicpd.org"
SRC_URI="mirror://sourceforge/musicpd/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 sparc x86"
IUSE=""

DEPEND="x11-libs/libXext
	x11-libs/libXpm"

S="${WORKDIR}"/${MY_P}

src_compile() {
	econf --with-default-port=6600
	emake || die "emake install failed."
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README THANKS TODO
}
