# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/recordmydesktop/recordmydesktop-0.3.1.ebuild,v 1.1 2007/01/20 08:40:16 hanno Exp $

DESCRIPTION="A desktop session recorder producing Ogg video/audio files"
HOMEPAGE="http://recordmydesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/recordmydesktop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND="media-libs/alsa-lib
	x11-libs/libXext
	x11-libs/libXdamage
	x11-libs/libXfixes
	media-libs/libogg
	media-libs/libvorbis
	media-libs/libtheora"

S=${WORKDIR}/${P}

src_install() {
	emake DESTDIR=${D} install || die "make install failed"
	dodoc NEWS README AUTHORS ChangeLog
}
