# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-mpeglib/artsplugin-mpeglib-3.5.0.ebuild,v 1.1 2005/11/22 22:13:56 danarmak Exp $

KMNAME=kdemultimedia
KMMODULE=mpeglib_artsplug
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="mpeglib plugin for arts"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/mpeglib)"

KMCOPYLIB="libmpeg mpeglib/lib/"
KMEXTRACTONLY="mpeglib/"

pkg_setup() {
	if ! useq arts; then
		eerror "${PN} needs the USE=\"arts\" enabled and also the kdelibs compiled with the USE=\"arts\" enabled"
		die
	fi
}
