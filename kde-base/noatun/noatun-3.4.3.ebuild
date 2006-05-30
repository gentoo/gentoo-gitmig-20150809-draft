# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/noatun/noatun-3.4.3.ebuild,v 1.9 2006/05/30 01:28:27 flameeyes Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE media player"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="xine audiofile"
RDEPEND="${DEPEND}
$(deprange 3.4.1 $MAXKDEVER kde-base/kdemultimedia-arts)
$(deprange $PV $MAXKDEVER kde-base/artsplugin-mpeglib)
$(deprange 3.4.1 $MAXKDEVER kde-base/artsplugin-mpg123)
	xine? ( $(deprange 3.4.1 $MAXKDEVER kde-base/artsplugin-xine) )
	audiofile? ( $(deprange 3.4.1 $MAXKDEVER kde-base/artsplugin-audiofile) )"
KMCOPYLIB="
	libartsgui_kde arts/gui/kde/
	libartsgui arts/gui/common/
	libartsmodules arts/modules/"
KMEXTRACTONLY="arts/"
