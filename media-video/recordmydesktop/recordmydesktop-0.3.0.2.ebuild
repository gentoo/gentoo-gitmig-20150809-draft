# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/recordmydesktop/recordmydesktop-0.3.0.2.ebuild,v 1.3 2006/12/23 22:52:37 peper Exp $

inherit eutils versionator

MY_P=${PN}-$(replace_version_separator 3 'r')

DESCRIPTION="A desktop session recorder producing Ogg video/audio files"
HOMEPAGE="http://recordmydesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/recordmydesktop/${MY_P}.tar.gz"

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
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_install() {
	emake DESTDIR=${D} install || die "make install failed"
	dodoc NEWS README AUTHORS ChangeLog
}
