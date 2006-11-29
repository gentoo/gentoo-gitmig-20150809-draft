# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/recordmydesktop/recordmydesktop-0.2.5.ebuild,v 1.1 2006/11/29 13:27:05 zzam Exp $

inherit eutils

DESCRIPTION="A desktop session recorder producing Ogg video/audio files"
HOMEPAGE="http://recordmydesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/recordmydesktop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="media-libs/alsa-lib
		x11-libs/libXext
		x11-libs/libXdamage
		x11-libs/libXfixes
		media-libs/libogg
		media-libs/libvorbis
		media-libs/libtheora"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-nosound.patch"
}

src_install() {
	emake DESTDIR=${D} install || die "make install failed"
	dodoc NEWS README AUTHORS ChangeLog
}
