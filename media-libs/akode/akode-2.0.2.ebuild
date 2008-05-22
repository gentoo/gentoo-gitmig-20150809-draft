# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/akode/akode-2.0.2.ebuild,v 1.6 2008/05/22 11:07:38 klausman Exp $

WANT_AUTOMAKE="1.9"
WANT_AUTOCONF="2.5"

inherit eutils autotools

MY_P=${P/_beta/b}
S="${WORKDIR}"/${MY_P}

DESCRIPTION="A simple framework to decode the most common audio formats."
HOMEPAGE="http://www.carewolf.com/"
#SRC_URI="http://www.carewolf.com/akode/${MY_P}.tar.gz"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/30375-${P}.tar.bz2"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="alpha ~amd64 hppa ~ia64 ~mips ~ppc ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="alsa jack flac mp3 oss speex vorbis"

DEPEND="media-libs/libsamplerate
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	flac? ( >=media-libs/flac-1.1.2 )
	mp3? ( media-libs/libmad )
	vorbis? ( media-libs/libvorbis )
	speex? ( media-libs/speex )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-amd64-flac-1.1.3.patch

	# gcc 4.3 compatibility fix. cf. bug 218300.
	epatch "${FILESDIR}"/${P}-gcc43.patch

	sed -i -e '/case $AUTO\(CONF\|HEADER\)_VERSION in/,+1 s/2\.5/2.[56]/g' \
		admin/cvs.sh

	emake -j1 -f admin/Makefile.common || die "unable to regenerate configure"

	elibtoolize
}

src_compile() {
	local myconf="--with-libsamplerate
				  $(use_with oss) $(use_with alsa) $(use_with jack)
				  $(use_with flac) $(use_with mp3 libmad)
				  $(use_with vorbis) $(use_with speex)
				  --without-polypaudio
				  --without-ffmpeg"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
