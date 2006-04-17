# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/exscalibar/exscalibar-1.0.4.ebuild,v 1.7 2006/04/17 01:00:36 wormo Exp $

inherit eutils qt3

DESCRIPTION="EXtendable, SCalable Architecture for Live, Interactive or Batch-orientated Audio-signal Refinement"
HOMEPAGE="http://exscalibar.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="mp3 vorbis fftw jack alsa doc"
DEPEND="$(qt_min_version 3.2)
	>=media-libs/libsndfile-1.0.0
	mp3? ( >=media-libs/libmad-0.15 )
	vorbis? ( >=media-libs/libvorbis-1.0.0 )
	fftw? ( >=sci-libs/fftw-3.0.0 )
	jack? (	>=media-sound/jack-audio-connection-kit-0.90.0 )
	alsa? (	>=media-libs/alsa-lib-0.9 )"

# FIXME: add GAT support

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/exscalibar-configure-disable-features.diff
	epatch ${FILESDIR}/exscalibar-1.0.4-gcc4-amd64.diff
}

src_compile () {
	export PATH="${QTDIR}/bin:${PATH}"

	export DISABLE_SNDFILE=1
	use mp3     || export DISABLE_MAD=1
	use vorbis  || export DISABLE_VORBISFILE=1
	use fftw    || export DISABLE_FFTW3=1
	use jack    || export DISABLE_JACK=1
	use alsa    || export DISABLE_ALSA=1

	./configure || die "configure failed"
	echo "QMAKE_CFLAGS_RELEASE = ${CFLAGS}" >> global.pro
	echo "QMAKE_CXXFLAGS_RELEASE = ${CXXFLAGS}" >> global.pro
	emake -j1 || die "emake failed"
}

src_install() {
	make INSTALL_ROOT="${D}" install || die "make install failed"

	dodoc CHANGELOG INSTALL NOTES README

	if use doc; then
		dodir "/usr/share/doc/${PF}/tex"
		cp -R doc/* "${D}/usr/share/doc/${PF}/tex/" || die
	fi
}
