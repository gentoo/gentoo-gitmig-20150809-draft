# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-mpeglib/artsplugin-mpeglib-3.4.3.ebuild,v 1.8 2006/03/25 22:05:07 agriffis Exp $

KMNAME=kdemultimedia
KMMODULE=mpeglib_artsplug
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="mpeglib plugin for arts"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="$(deprange 3.4.1 $MAXKDEVER kde-base/mpeglib)"
OLDDEPEND="~kde-base/mpeglib-$PV"
KMCOPYLIB="libmpeg mpeglib/lib/"
KMEXTRACTONLY="mpeglib/"

pkg_setup() {
	if ! useq arts; then
		eerror "${PN} needs the USE=\"arts\" enabled and also the kdelibs compiled with the USE=\"arts\" enabled"
		die
	fi
}
