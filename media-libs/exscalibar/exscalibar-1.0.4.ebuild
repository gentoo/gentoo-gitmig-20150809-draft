# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/exscalibar/exscalibar-1.0.4.ebuild,v 1.2 2006/02/13 19:44:19 hanno Exp $

DESCRIPTION="EXtendable, SCalable Architecture for Live, Interactive or Batch-orientated Audio-signal Refinement"
HOMEPAGE="http://exscalibar.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="sndfile mp3 vorbis fftw jack alsa doc"
DEPEND="=x11-libs/qt-3*
	sndfile? ( >=media-libs/libsndfile-1.0.0 )
	mp3? ( >=media-libs/libmad-0.15 )
	vorbis? ( >=media-libs/libvorbis-1.0.0 )
	fftw? ( >=sci-libs/fftw-3.0.0 )
	jack? (	>=media-sound/jack-audio-connection-kit-0.90.0 )
	alsa? (	>=media-libs/alsa-lib-0.9 )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/exscalibar-configure-disable-features.diff
}

src_compile () {
	export PATH="/usr/qt/3/bin:${PATH}"

	use sndfile || export DISABLE_SNDFILE=1
	use mp3 || export DISABLE_MAD=1
	use vorbis || export DISABLE_OGGFILE=1
	use fftw || export DISABLE_FFTW3=1
	use jack || export DISABLE_JACK=1
	use alsa || export DISABLE_ALSA=1

	econf || die "configure failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make INSTALL_ROOT="${D}" install || die "make install failed"

	dodoc CHANGELOG INSTALL NOTES README

	if use doc ; then
		dodir /usr/share/doc/${PF}/tex/
		cp -R doc/* ${D}/usr/share/doc/${PF}/tex/ || die
	fi
}
