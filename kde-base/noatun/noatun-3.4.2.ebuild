# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/noatun/noatun-3.4.2.ebuild,v 1.2 2005/08/08 20:38:57 kloeri Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE media player"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="xine audiofile"
RDEPEND="${DEPEND}
$(deprange 3.4.1 $MAXKDEVER kde-base/kdemultimedia-arts)
$(deprange 3.4.1 $MAXKDEVER kde-base/artsplugin-mpeglib)
$(deprange 3.4.1 $MAXKDEVER kde-base/artsplugin-mpg123)
	xine? ( $(deprange 3.4.1 $MAXKDEVER kde-base/artsplugin-xine) )
	audiofile? ( $(deprange 3.4.1 $MAXKDEVER kde-base/artsplugin-audiofile) )"
KMCOPYLIB="
	libartsgui_kde arts/gui/kde/
	libartsgui arts/gui/common/
	libartsmodules arts/modules/"
KMEXTRACTONLY="arts/"

pkg_setup() {
	if ! useq arts; then
		eerror "${PN} needs the USE=\"arts\" enabled and also the kdelibs compiled with the USE=\"arts\" enabled"
		die
	fi
}