# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kwave/kwave-0.7.9.ebuild,v 1.4 2007/11/18 21:56:26 aballier Exp $

inherit kde flag-o-matic

DESCRIPTION="Kwave is a sound editor for KDE."
HOMEPAGE="http://kwave.sourceforge.net/"
SRC_URI="mirror://sourceforge/kwave/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="doc mmx"

RDEPEND="media-libs/alsa-lib
	media-libs/audiofile
	media-libs/id3lib
	media-libs/libmad
	media-libs/libogg
	media-libs/libvorbis
	media-libs/flac
	sci-libs/gsl"

DEPEND="${RDEPEND}
	kde-base/arts
	|| ( kde-base/kdemultimedia-arts kde-base/kdemultimedia )
	|| ( kde-base/kdesdk-misc kde-base/kdesdk )
	app-text/recode
	media-gfx/imagemagick"

need-kde 3.4

pkg_setup() {
	if ! built_with_use kde-base/kdelibs arts ; then
		eerror "KWave needs aRts, please rebuild kdelibs with arts use flag enabled."
		die
	fi

	if ! built_with_use --missing true media-libs/flac cxx; then
		eerror "To build ${PN} you need the C++ bindings for flac."
		eerror "Please enable the cxx USE flag for media-libs/flac"
		die "Missing FLAC C++ bindings."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}_flac-v1.1.3_and_v1.1.4-support.diff"
	epatch "${FILESDIR}/${P}-debian-431199.diff"
}

src_compile() {
	eautoreconf
	local myconf="--without-builtin-libaudiofile"

	myconf="$(use_enable doc)"
	use mmx && append-flags "-mmmx"

	kde_src_compile
}
