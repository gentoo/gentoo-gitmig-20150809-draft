# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-3.4.0_beta2.ebuild,v 1.3 2005/02/13 02:00:52 greg_g Exp $

inherit kde-dist eutils flag-o-matic

DESCRIPTION="KDE multimedia apps: noatun, kscd, juk..."

KEYWORDS="~x86 ~amd64"
IUSE="alsa audiofile encode flac gstreamer oggvorbis speex theora xine"

DEPEND="~kde-base/kdebase-${PV}
	media-sound/cdparanoia
	audiofile? ( media-libs/audiofile )
	flac? ( media-libs/flac )
	encode? ( media-sound/lame )
	oggvorbis? ( media-sound/vorbis-tools )
	xine? ( >=media-libs/xine-lib-1_beta12 )
	alsa? ( media-libs/alsa-lib )
	speex? ( media-libs/speex )
	theora? ( media-libs/libtheora )
	gstreamer? ( >=media-libs/gstreamer-0.8
		     >=media-libs/gst-plugins-0.8 )
	>=media-libs/taglib-1.2
	media-libs/tunepimp"

PATCHES="${FILESDIR}/kdemultimedia-3.4.0_beta1-amd64.patch
	$FILESDIR/artsc-typo.diff" # remove after beta2

src_unpack() {
	# necessary because arts-typo.diff affects a Makefile.am
	kde_src_unpack
	rm $S/configure
}

src_compile() {
	use xine && myconf="$myconf --with-xine-prefix=/usr"
	use xine || DO_NOT_COMPILE="$DO_NOT_COMPILE xine_artsplugin"

	myconf="${myconf} --with-cdparanoia --enable-cdparanoia"
	myconf="${myconf} $(use_with alsa arts-alsa) $(use_with alsa)"
	myconf="${myconf} $(use_with oggvorbis vorbis) $(use_with encode lame)"

	# make -j2 fails, at least on ppc
	use ppc && export MAKEOPTS="$MAKEOPTS -j1"
	use hppa && append-flags -ffunction-sections

	kde_src_compile
}
