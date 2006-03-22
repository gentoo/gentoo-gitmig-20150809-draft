# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/juk/juk-3.5.2.ebuild,v 1.1 2006/03/22 20:14:54 danarmak Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Jukebox and music manager for KDE"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="flac gstreamer mp3 vorbis musicbrainz"

DEPEND="media-libs/taglib
	media-libs/akode
	musicbrainz? ( 	media-libs/tunepimp
			media-libs/musicbrainz )
	gstreamer? ( =media-libs/gstreamer-0.8*
	             =media-libs/gst-plugins-0.8* )"

RDEPEND="${DEPEND}
	gstreamer? ( mp3? ( =media-plugins/gst-plugins-mad-0.8* )
		     vorbis? ( =media-plugins/gst-plugins-ogg-0.8*
				  =media-plugins/gst-plugins-vorbis-0.8* )
		     flac? ( =media-plugins/gst-plugins-flac-0.8* ) )"

KMEXTRACTONLY="arts/configure.in.in"

pkg_setup() {
	if ! useq arts && ! useq gstreamer; then
		eerror "${PN} needs USE=\"arts\" (and kdelibs compiled with USE=\"arts\") or USE=\"gstreamer\""
		die
	fi
}

src_compile() {
	local myconf="--with-akode $(use_with gstreamer)
	              $(use_with musicbrainz)"

	kde-meta_src_compile
}
