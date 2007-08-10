# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kttsd/kttsd-3.5.7.ebuild,v 1.7 2007/08/10 13:51:45 angelos Exp $
KMNAME=kdeaccessibility
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE text-to-speech subsystem"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86"
IUSE="akode alsa gstreamer"
DEPEND="akode? ( media-libs/akode )
	alsa? ( media-libs/alsa-lib )
	gstreamer? ( =media-libs/gstreamer-0.8*
	             =media-libs/gst-plugins-0.8* )
	$(deprange-dual $PV $MAXKDEVER kde-base/kcontrol)
	!arts? ( !alsa? ( !gstreamer? ( media-libs/akode ) ) )"

RDEPEND="${DEPEND}
	|| ( app-accessibility/festival
	     app-accessibility/epos
	     app-accessibility/flite
	     app-accessibility/freetts )"

pkg_setup() {
	kde_pkg_setup
	if ! use arts && ! use alsa && ! use gstreamer && ! use akode ; then
		ewarn "No audio backend chosen. Defaulting to media-libs/akode."
	fi
}

src_compile() {
	local myconf="$(use_with alsa) $(use_with gstreamer)"

	if ! use arts && ! use alsa && ! use gstreamer ; then
		myconf="${myconf} --with-akokde"
	else
		myconf="${myconf} $(use_with akode)"
	fi

	kde-meta_src_compile
}
