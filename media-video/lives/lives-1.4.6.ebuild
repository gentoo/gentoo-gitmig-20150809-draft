# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/lives/lives-1.4.6.ebuild,v 1.1 2011/09/30 19:13:53 ssuominen Exp $

EAPI=4
inherit eutils

MY_P=LiVES-${PV}

DESCRIPTION="LiVES is a Video Editing System"
HOMEPAGE="http://lives.sf.net"
SRC_URI="http://www.xs4all.nl/~salsaman/lives/current/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="libvisual matroska nls ogg theora" # static-libs

# FIXME (incomplete workaround in place):
# !!<${CATEGORY}/${PF} is because if you have lives installed, the bundled
# libweed never gets installed in second emerge
# See also bug 295293
RDEPEND="media-video/mplayer
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )
	dev-lang/perl
	>=dev-libs/glib-2.14
	>=x11-libs/gtk+-2.16:2
	media-libs/libsdl
	media-libs/libv4l
	virtual/ffmpeg
	virtual/jpeg
	media-sound/sox
	virtual/cdrtools
	|| ( dev-lang/python:2.7 dev-lang/python:2.6 )
	media-plugins/frei0r-plugins
	media-sound/jack-audio-connection-kit
	>=media-video/mjpegtools-1.6.2
	sys-libs/libavc1394
	libvisual? ( media-libs/libvisual )
	matroska? ( media-video/mkvtoolnix )
	ogg? ( media-sound/ogmtools )
	theora? ( media-libs/libtheora )
	!!<${CATEGORY}/${PF}"
DEPEND="${DEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS BUGS ChangeLog FEATURES GETTING.STARTED NEWS README )

src_prepare() {
	esvn_clean

	# Use python 2.x as per reference in plugins
	sed -i \
		-e '/#!.*env/s:python:python2:' \
		lives-plugins/plugins/encoders/multi_encoder* \
		lives-plugins/marcos-encoders/lives_*_encoder* || die

}

src_configure() {
	# $(use_enable static-libs static)
	econf \
		--disable-static \
		$(use_enable libvisual) \
		$(use_enable nls)
}

src_install() {
	default
	find "${ED}"usr -name '*.la' -exec rm -f {} +
	# use static-libs ||
	rm -f "${ED}"usr/lib*/libweed-*.a
}
