# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qjackconnect/qjackconnect-0.0.3b-r1.ebuild,v 1.14 2004/12/04 11:42:43 eradicator Exp $

IUSE=""

DESCRIPTION="A QT based patchbay for the JACK Audio Connection Kit"
HOMEPAGE="http://www.suse.de/~mana/jack.html"
SRC_URI="ftp://ftp.suse.com/pub/people/mana/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"

DEPEND="virtual/libc
	>=x11-libs/qt-3.0.5
	media-libs/alsa-lib
	media-sound/jack-audio-connection-kit"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed \
		-e "s:/usr/lib/qt3:/usr/qt/3:" \
		-e "s:-O2 -g:${CXXFLAGS}:" \
		< make_qjackconnect > Makefile
}

src_compile() {
	make || die
}

src_install() {
	dobin qjackconnect
}
