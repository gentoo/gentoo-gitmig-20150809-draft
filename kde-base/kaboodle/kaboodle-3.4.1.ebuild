# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaboodle/kaboodle-3.4.1.ebuild,v 1.8 2005/08/08 20:36:37 kloeri Exp $

KMNAME=kdemultimedia
MAXKDEVER=3.4.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="The Lean KDE Media Player"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86"
IUSE="xine audiofile"

OLDRDEPEND="
	~kde-base/kdemultimedia-arts-$PV
	~kde-base/artsplugin-mpeglib-$PV
	~kde-base/artsplugin-mpg123-$PV
	xine? ( ~kde-base/artsplugin-xine-$PV )
	audiofile? ( ~kde-base/artsplugin-audiofile-$PV )"
RDEPEND="$(deprange $PV 3.4.2 kde-base/kdemultimedia-arts)
	$(deprange $PV 3.4.2 kde-base/artsplugin-mpeglib)
	$(deprange $PV 3.4.2 kde-base/artsplugin-mpg123)
	xine? ( $(deprange $PV 3.4.2 kde-base/artsplugin-xine) )
	audiofile? ( $(deprange $PV 3.4.2 kde-base/artsplugin-audiofile) )"

KMEXTRACTONLY="arts/"

pkg_setup() {
	if ! useq arts; then
		eerror "${PN} needs the USE=\"arts\" enabled and also the kdelibs compiled with the USE=\"arts\" enabled"
		die
	fi
}