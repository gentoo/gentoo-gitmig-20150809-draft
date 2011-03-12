# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/galan/galan-0.3.0_beta7.ebuild,v 1.3 2011/03/12 09:24:01 radhermit Exp $

EAPI=2

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
	opengl? ( >=x11-libs/gtkglarea-1.99.0 )
	esd? ( media-sound/esound )
	jack? ( >=media-sound/jack-audio-connection-kit-0.80.0 )
	media-libs/liblrdf
	media-libs/ladspa-sdk
	media-libs/audiofile
	media-libs/libsndfile
	sci-libs/fftw:2.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO doc/
}
