# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/asunder/asunder-1.5.ebuild,v 1.1 2008/04/28 16:38:36 drac Exp $

DESCRIPTION="a graphical Audio CD ripper and encoder with support for WAV, MP3, OggVorbis and FLAC."
HOMEPAGE="http://littlesvr.ca/asunder"
SRC_URI="http://littlesvr.ca/${PN}/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="flac mp3 vorbis wavpack"

RDEPEND=">=x11-libs/gtk+-2.4
	>=media-libs/libcddb-0.9.5
	media-sound/cdparanoia
	mp3? ( media-sound/lame )
	vorbis? ( media-sound/vorbis-tools )
	flac? ( media-libs/flac )
	wavpack? ( media-sound/wavpack )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
