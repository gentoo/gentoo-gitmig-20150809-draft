# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/easytag/easytag-2.1.2.ebuild,v 1.1 2007/07/12 12:09:15 drac Exp $

DESCRIPTION="GTK+ utility for editing MP2, MP3, MP4, FLAC, Ogg and other media tags"
HOMEPAGE="http://easytag.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="aac flac mp3 speex vorbis wavpack"

RDEPEND=">=x11-libs/gtk+-2.4.1
	mp3? ( >=media-libs/id3lib-3.8.2
		media-libs/libid3tag )
	flac? ( media-libs/flac >=media-libs/libvorbis-1.0 )
	vorbis? ( >=media-libs/libvorbis-1.0 )
	aac? ( media-libs/libmp4v2 )
	wavpack? ( media-sound/wavpack )
	speex? ( media-libs/speex )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_compile() {
	econf $(use_enable mp3) \
		$(use_enable mp3 id3v23) \
		$(use_enable vorbis ogg) \
		$(use_enable flac) \
		$(use_enable aac mp4) \
		$(use_enable wavpack) \
		$(use_enable speex) \
		--enable-shared
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog README THANKS TODO USERS-GUIDE
}
