# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/akode/akode-2.0_rc1.ebuild,v 1.12 2006/10/19 19:25:49 flameeyes Exp $

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A simple framework to decode the most common audio formats."
HOMEPAGE="http://www.carewolf.com/akode/"
SRC_URI="http://www.kde-look.org/content/files/30375-${MY_P}.tar.gz"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="alsa jack flac mp3 oss speex vorbis"

DEPEND="media-libs/libsamplerate
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	flac? ( ~media-libs/flac-1.1.2 )
	mp3? ( media-libs/libmad )
	vorbis? ( media-libs/libvorbis )
	speex? ( media-libs/speex )"

src_compile() {
	local myconf="--with-libsamplerate
	              $(use_with oss) $(use_with alsa) $(use_with jack)
	              $(use_with flac) $(use_with mp3 libmad)
	              $(use_with vorbis) $(use_with speex)
	              --without-polypaudio"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README
}
