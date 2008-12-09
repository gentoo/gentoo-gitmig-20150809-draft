# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kid3/kid3-1.1.ebuild,v 1.3 2008/12/09 20:59:48 ranger Exp $

EAPI="2"

inherit eutils cmake-utils kde-functions

DESCRIPTION="A simple ID3 tag editor for QT/KDE."
HOMEPAGE="http://kid3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kid3/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="+flac +musicbrainz"

# Kde cannot be disabled configure violates
# sandbox and i aint fixing it.
# Currently we preffer kde4 over kde3.
DEPEND=">=media-libs/id3lib-3.8.3
	>=media-libs/taglib-1.4-r1
	media-libs/libmp4v2
	media-libs/libvorbis
	flac? (	media-libs/flac[cxx] )
	|| (
		>=kde-base/kdelibs-3.9
		kde-base/kdelibs:3.5
	)
	musicbrainz? (
		media-libs/musicbrainz:3
		media-libs/tunepimp
	)"

src_configure() {
	if has_version ">=kde-base/kdelibs-3.9"; then
		# we shall use kde4
		# there is option WITH_KDE but kde is needed anyway
		# so forcing
		mycmakeargs="${mycmakeargs}
		-DWITH_KDE=ON
		-DWITH_TAGLIB=ON
		-DWITH_VORBIS=ON
		$(cmake-utils_use_with flac FLAC)
		$(cmake-utils_use_with musicbrainz TUNEPIMP)
		"
		cmake-utils_src_configure
	else
		# we shall use kde3
		# Compile fails without taglib, forced on.
		# Ditto for vorbis, so there you go.
		set-qtdir 3
		set-kdedir 3
		econf \
			--with-kde \
			--with-taglib \
			--without-arts \
			--with-vorbis \
			$(use_with flac) \
			$(use_with musicbrainz) \
			--with-extra-includes=/usr/kde/3.5/include/
		# there is noone having version older than 3.5 so this is no problem
	fi
}
