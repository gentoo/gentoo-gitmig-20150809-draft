# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/juk/juk-3.4.0_beta1.ebuild,v 1.4 2005/02/08 15:08:01 greg_g Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Jukebox and music manager for KDE"
KEYWORDS="~x86"
IUSE="gstreamer"
DEPEND="media-libs/taglib
	media-libs/tunepimp
	gstreamer? ( >=media-libs/gstreamer-0.8 >=media-libs/gst-plugins-0.8 )"
KMEXTRACTONLY="arts/configure.in.in"

pkg_setup() {
	if ! useq arts && ! useq gstreamer; then
		eerror "${PN} needs USE=\"arts\" (and kdelibs compiled with USE=\"arts\") or USE=\"gstreamer\""
		die
	fi
}
