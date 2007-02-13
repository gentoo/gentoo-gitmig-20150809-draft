# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sweep/sweep-0.9.2.ebuild,v 1.1 2007/02/13 20:01:35 aballier Exp $

inherit eutils autotools

DESCRIPTION="Audio editor and live playback tool"
HOMEPAGE="http://www.metadecks.org/software/sweep/"
SRC_URI="mirror://sourceforge/sweep/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="alsa ladspa vorbis mp3 libsamplerate speex"

DEPEND=">=media-libs/libsndfile-1.0
	>=x11-libs/gtk+-2.4.0
	>=dev-libs/glib-2.2.0
	alsa? ( media-libs/alsa-lib )
	libsamplerate? ( media-libs/libsamplerate )
	speex? ( media-libs/speex )
	vorbis? ( media-libs/libogg media-libs/libvorbis )
	mp3? ( media-libs/libmad )
	ladspa? ( media-libs/ladspa-sdk )"

LANGS="de el es_ES fr hu it pl ru"

for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done

src_compile() {
	use vorbis || myconf="${myconf} --disable-oggvorbis"
	use mp3    || myconf="${myconf} --disable-mad"
	use speex  || myconf="${myconf} --disable-speex"
	use libsamplerate || myconf="${myconf} --disable-src"
	econf ${myconf} || die "econf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
