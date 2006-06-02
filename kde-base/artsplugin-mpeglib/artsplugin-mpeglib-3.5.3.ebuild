# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-mpeglib/artsplugin-mpeglib-3.5.3.ebuild,v 1.2 2006/06/02 00:36:59 flameeyes Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
KMMODULE=mpeglib_artsplug
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="mpeglib plugin for arts"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
DEPEND="$(deprange 3.5.1 $MAXKDEVER kde-base/mpeglib)"

KMCOPYLIB="libmpeg mpeglib/lib/"
KMEXTRACTONLY="mpeglib/"

PATCHES="${FILESDIR}/${PN}-3.5.2-libarts.patch"
