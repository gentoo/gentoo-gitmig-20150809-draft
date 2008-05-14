# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-meta/kdemultimedia-meta-3.5.9.ebuild,v 1.6 2008/05/14 17:40:45 corsair Exp $

EAPI="1"
inherit kde-functions
DESCRIPTION="kdemultimedia - merge this to pull in all kdemultimedia-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="arts xine"

RDEPEND="arts? ( >=kde-base/artsplugin-akode-${PV}:${SLOT}
		>=kde-base/artsplugin-audiofile-${PV}:${SLOT}
		xine? ( >=kde-base/artsplugin-xine-${PV}:${SLOT} )
		>=kde-base/juk-${PV}:${SLOT}
		>=kde-base/kaboodle-${PV}:${SLOT}
		>=kde-base/kaudiocreator-${PV}:${SLOT}
		>=kde-base/kdemultimedia-arts-${PV}:${SLOT}
		>=kde-base/krec-${PV}:${SLOT}
		>=kde-base/noatun-${PV}:${SLOT} )
	>=kde-base/kdemultimedia-kappfinder-data-${PV}:${SLOT}
	>=kde-base/kdemultimedia-kfile-plugins-${PV}:${SLOT}
	>=kde-base/kdemultimedia-kioslaves-${PV}:${SLOT}
	>=kde-base/kmid-${PV}:${SLOT}
	>=kde-base/kmix-${PV}:${SLOT}
	>=kde-base/kscd-${PV}:${SLOT}
	>=kde-base/libkcddb-${PV}:${SLOT}"

# Not really useful, these are scheduled for being removed from KDE soon.
#>=kde-base/artsplugin-mpeglib-${PV}:${SLOT}
#>=kde-base/artsplugin-mpg123-${PV}:${SLOT}
#>=kde-base/mpeglib-${PV}:${SLOT}
