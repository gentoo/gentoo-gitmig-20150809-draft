# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia/kdemultimedia-3.3.2.ebuild,v 1.12 2005/01/25 01:05:53 vapier Exp $

inherit kde-dist flag-o-matic eutils

DESCRIPTION="KDE multimedia apps: noatun, kscd, artsbuilder..."

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="alsa audiofile cdparanoia encode flac oggvorbis speex xine"

DEPEND="~kde-base/kdebase-${PV}
	audiofile? ( media-libs/audiofile )
	cdparanoia? ( media-sound/cdparanoia )
	flac? ( media-libs/flac )
	encode? ( media-sound/lame )
	oggvorbis? ( media-sound/vorbis-tools )
	xine? ( >=media-libs/xine-lib-1_beta12 )
	alsa? ( media-libs/alsa-lib )
	speex? ( media-libs/speex !=media-libs/speex-1.1.4 )
	>=media-libs/taglib-1.2
	media-libs/tunepimp
	!media-sound/juk"

src_unpack() {
	kde_src_unpack
	cd ${S}
	# bug 74961
	if [ "${ARCH}" != "amd64" ] ; then
		epatch ${FILESDIR}/${PN}-64bit.patch
	fi
}

src_compile() {
	replace-flags -O3 -O2
	# Still persists with 3.2.1 - kaboodle
	filter-flags "-fno-default-inline"

	use xine && myconf="$myconf --with-xine-prefix=/usr"
	use xine || DO_NOT_COMPILE="$DO_NOT_COMPILE xine_artsplugin"

	myconf="${myconf} `use_with cdparanoia`"

	# make -j2 fails, at least on ppc
	use ppc && export MAKEOPTS="$MAKEOPTS -j1"
	use hppa && append-flags -ffunction-sections

	# alsa 0.9 not supported
	use alsa	&& myconf="$myconf --with-alsa --with-arts-alsa" || myconf="$myconf --without-alsa --disable-alsa"
	use oggvorbis	&& myconf="$myconf --with-vorbis=/usr"		|| myconf="$myconf --without-vorbis"
	use encode	&& myconf="$myconf --with-lame=/usr" || myconf="$myconf --without-lame"

	myconf="$myconf --disable-strict --disable-warnings"

	kde_src_compile
}
