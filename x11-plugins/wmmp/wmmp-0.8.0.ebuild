# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmp/wmmp-0.8.0.ebuild,v 1.6 2005/10/07 15:43:46 flameeyes Exp $

IUSE=""

DESCRIPTION="A Window Maker dock app client for Music Player Daemon(media-sound/mpd)"
SRC_URI="http://mercury.chem.pitt.edu/~shank/${P/wm/WM}.tar.gz"
HOMEPAGE="http://www.musicpd.org"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~alpha amd64"

S=${WORKDIR}/${P/wm/WM}

src_install () {
	dobin src/WMmp

	doman doc/WMmp.1

	dodoc AUTHORS README THANKS TODO
}


