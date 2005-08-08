# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-meta/kdemultimedia-meta-3.4.2.ebuild,v 1.2 2005/08/08 20:40:33 kloeri Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdemultimedia - merge this to pull in all kdemultimedia-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="arts xine"

RDEPEND="arts? ( $(deprange 3.4.1 $MAXKDEVER kde-base/artsplugin-audiofile)
		$(deprange 3.4.1 $MAXKDEVER kde-base/artsplugin-mpeglib)
		$(deprange 3.4.1 $MAXKDEVER kde-base/artsplugin-mpg123)
		xine? ( $(deprange 3.4.1 $MAXKDEVER kde-base/artsplugin-xine) )
		$(deprange $PV $MAXKDEVER kde-base/juk)
		$(deprange 3.4.1 $MAXKDEVER kde-base/kaboodle)
		$(deprange $PV $MAXKDEVER kde-base/kaudiocreator)
		$(deprange $PV $MAXKDEVER kde-base/akode)
		$(deprange 3.4.1 $MAXKDEVER kde-base/kdemultimedia-arts)
		$(deprange $PV $MAXKDEVER kde-base/krec)
		$(deprange $PV $MAXKDEVER kde-base/noatun) )
	$(deprange $PV $MAXKDEVER kde-base/kdemultimedia-kappfinder-data)
	$(deprange $PV $MAXKDEVER kde-base/kdemultimedia-kfile-plugins)
	$(deprange $PV $MAXKDEVER kde-base/kdemultimedia-kioslaves)
	$(deprange 3.4.1 $MAXKDEVER kde-base/kmid)
	$(deprange $PV $MAXKDEVER kde-base/kmix)
	$(deprange $PV $MAXKDEVER kde-base/kscd)
	$(deprange $PV $MAXKDEVER kde-base/libkcddb)
	$(deprange 3.4.1 $MAXKDEVER kde-base/mpeglib)"
