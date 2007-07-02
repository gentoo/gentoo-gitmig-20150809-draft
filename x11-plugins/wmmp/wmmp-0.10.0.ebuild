# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmp/wmmp-0.10.0.ebuild,v 1.9 2007/07/02 15:02:55 peper Exp $

IUSE=""

MY_P=${P/wm/WM}
DESCRIPTION="A Window Maker dock app client for Music Player Daemon(media-sound/mpd)"
SRC_URI="mirror://sourceforge/musicpd/${MY_P}.tar.gz"
RESTRICT="mirror"
HOMEPAGE="http://www.musicpd.org"

DEPEND="|| (
		( x11-libs/libXext x11-libs/libXpm )
		<virtual/x11-7 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha amd64"

S=${WORKDIR}/${MY_P}

src_install () {
	emake install DESTDIR=${D} || die

	dodoc AUTHORS README THANKS TODO
}
