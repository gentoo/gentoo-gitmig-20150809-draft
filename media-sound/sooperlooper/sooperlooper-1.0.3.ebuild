# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sooperlooper/sooperlooper-1.0.3.ebuild,v 1.3 2006/02/16 08:55:45 flameeyes Exp $

DESCRIPTION="Live looping sampler with immediate loop recording"
HOMEPAGE="http://essej.net/sooperlooper/index.html"
SRC_URI="http://essej.net/sooperlooper/${P}.tar.gz"
RESTRICT=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=media-sound/jack-audio-connection-kit-0.80.0
		>=x11-libs/wxGTK-2.4
		>=media-libs/liblo-0.17
		=dev-libs/libsigc++-1.2*
		media-libs/libsndfile
		media-libs/libsamplerate
		sys-libs/ncurses
		dev-libs/libxml2"

src_install() {
	make DESTDIR=${D} install || die
}
