# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-outlame/bmp-outlame-0.2.2.ebuild,v 1.1 2004/11/20 19:08:04 chainsaw Exp $

IUSE=""
inherit eutils

MY_P=${P/bmp-/beep-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="MP3 (Lame) output plugin for beep media player"
HOMEPAGE="http://www.magiclinux.org/people/jiangtao9999/bmp/tar/"
SRC_URI="http://www.magiclinux.org/people/jiangtao9999/bmp/tar/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="media-sound/lame
	>=media-sound/beep-media-player-0.9.7_rc2-r3"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PV}-includes.patch
}
src_install() {
	make DESTDIR=${D} install || die
}
