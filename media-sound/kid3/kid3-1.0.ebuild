# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kid3/kid3-1.0.ebuild,v 1.2 2008/12/06 19:03:55 nixnut Exp $

EAPI=1
ARTS_REQUIRED=never

inherit kde

DESCRIPTION="A simple ID3 tag editor for QT/KDE."
HOMEPAGE="http://kid3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kid3/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ppc ~ppc64 ~sparc ~x86"
IUSE="+flac +musicbrainz +vorbis"

DEPEND=">=media-libs/id3lib-3.8.3
	>=media-libs/taglib-1.4-r1
	media-libs/libmp4v2
	media-libs/libvorbis
	flac? (
		media-libs/flac
	)
	musicbrainz? (
		media-libs/musicbrainz:3
		media-libs/tunepimp
	)"

need-kde 3

pkg_setup() {
	if use flac && ! built_with_use --missing true media-libs/flac cxx; then
		eerror "To build ${PN} with flac support you need the C++ bindings for flac."
		eerror "Please enable the cxx USE flag for media-libs/flac"
		die "Missing FLAC C++ bindings."
	fi

	# Support for the KDE libraries is optional,
	# but the configure step that detects them
	# cannot be avoided. So KDE support is forced on.
	# Compile fails without taglib, forced on.
	# Ditto for vorbis, so there you go.
	myconf="--with-kde
		--with-taglib
		--without-arts
		--with-vorbis
		$(use_with flac)
		$(use_with musicbrainz)"
}
