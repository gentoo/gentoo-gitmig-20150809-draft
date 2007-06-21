# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kwave/kwave-0.7.9.ebuild,v 1.1 2007/06/21 06:00:51 philantrop Exp $

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
	if ! built_with_use kdelibs arts ; then
		eerror "KWave needs aRts, please rebuild kdelibs with arts use flag enabled."
		die
	fi
}

src_compile() {
	eautoreconf
	local myconf="--without-builtin-libaudiofile"

	myconf="$(use_enable doc)"
	use mmx && append-flags "-mmmx"

	kde_src_compile
}
