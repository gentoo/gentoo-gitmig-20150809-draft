# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sweep/sweep-0.9.1.ebuild,v 1.2 2006/12/14 16:24:41 joker Exp $

DESCRIPTION="Audio editor and live playback tool"
HOMEPAGE="http://www.metadecks.org/software/sweep/"
SRC_URI="http://www.metadecks.org/software/sweep/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="alsa ladspa vorbis mp3 speex"

DEPEND="media-libs/libsamplerate
	>=media-libs/libsndfile-1.0
	>=x11-libs/gtk+-2.0.0
	speex? ( media-libs/speex )
	alsa? ( media-libs/alsa-lib )
	vorbis? ( media-libs/libogg media-libs/libvorbis )
	mp3? ( media-libs/libmad )
	ladspa? ( media-libs/ladspa-sdk )"

src_compile() {
	myconf="$(use_enable alsa)"
	myconf="${myconf} yconf="$(use_enable alsa)
	use vorbis || myconf="${myconf} --disable-oggvorbis"
	use mp3    || myconf="${myconf} --disable-mad"
	use speex  || myconf="${myconf} --disable-speex"
	econf ${myconf} || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
