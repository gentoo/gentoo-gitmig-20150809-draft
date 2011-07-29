# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/galan/galan-0.3.0_beta7.ebuild,v 1.5 2011/07/29 09:47:27 ssuominen Exp $

EAPI=4
inherit flag-o-matic toolchain-funcs

DESCRIPTION="gAlan - Graphical Audio Language"
HOMEPAGE="http://galan.sourceforge.net/"
SRC_URI="mirror://sourceforge/galan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="vorbis alsa opengl esd jack"

RDEPEND="x11-libs/gtk+:2
	vorbis? ( >=media-sound/vorbis-tools-1.0 )
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc1 )
	opengl? ( >=x11-libs/gtkglarea-1.99.0:2 )
	esd? ( media-sound/esound )
	jack? ( >=media-sound/jack-audio-connection-kit-0.80.0 )
	media-libs/liblrdf
	media-libs/ladspa-sdk
	media-libs/audiofile
	media-libs/libsndfile
	sci-libs/fftw:2.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS NEWS NOTES README TODO )

src_configure() {
	# Use lrdf.pc to get -I/usr/include/raptor2 (lrdf.h -> raptor.h)
	append-cppflags $($(tc-getPKG_CONFIG) --cflags lrdf)
	econf --disable-static
}

src_install() {
	default
	find "${D}" -name '*.la' -exec rm -f {} +
}
