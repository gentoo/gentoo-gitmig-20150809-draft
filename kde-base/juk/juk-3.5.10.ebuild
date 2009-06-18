# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/juk/juk-3.5.10.ebuild,v 1.6 2009/06/18 04:56:35 jer Exp $

KMNAME=kdemultimedia
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="Jukebox and music manager for KDE."
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="akode gstreamer"

RDEPEND="media-libs/taglib
	gstreamer? ( media-libs/gst-plugins-base:0.10 )
	akode? ( media-libs/akode )
	!arts? ( !gstreamer? ( media-libs/akode ) )"

DEPEND="${RDEPEND}"

PDEPEND="gstreamer? ( media-plugins/gst-plugins-meta:0.10 )"

KMEXTRACTONLY="arts/configure.in.in"

pkg_setup() {
	kde_pkg_setup
	if ! use arts && ! use gstreamer && ! use akode ; then
		ewarn "No audio backend chosen. Defaulting to media-libs/akode."
	fi
}

src_compile() {
	local myconf="$(use_with gstreamer) --without-musicbrainz"

	if ! use arts && ! use gstreamer ; then
		myconf="${myconf} --with-akode"
	else
		if ! use akode ; then
			# work around broken configure
			export include_akode_ffmpeg_FALSE='#'
			export include_akode_mpc_FALSE='#'
			export include_akode_mpeg_FALSE='#'
			export include_akode_xiph_FALSE='#'
		fi
		myconf="${myconf} $(use_with akode)"
	fi

	kde-meta_src_compile
}
