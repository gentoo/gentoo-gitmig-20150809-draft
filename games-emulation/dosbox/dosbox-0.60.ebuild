# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox/dosbox-0.60.ebuild,v 1.6 2004/07/14 14:32:48 agriffis Exp $

inherit eutils games

DESCRIPTION="DOS emulator"
HOMEPAGE="http://dosbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/dosbox/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="alsa png"

DEPEND="png? ( media-libs/libpng sys-libs/zlib )
	alsa? ( media-libs/alsa-lib )
	media-libs/sdl-net
	>=media-libs/libsdl-1.2.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-alsa-1.0.0.patch
}

src_compile() {
	egamesconf \
		`use_enable alsa alsatest` \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS
	prepgamesdirs
}
