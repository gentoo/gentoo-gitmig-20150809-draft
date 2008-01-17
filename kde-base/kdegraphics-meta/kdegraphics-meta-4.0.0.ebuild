# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-meta/kdegraphics-meta-4.0.0.ebuild,v 1.1 2008/01/17 23:48:46 philantrop Exp $

EAPI="1"

inherit kde4-functions

DESCRIPTION="kdegraphics - merge this to pull in all kdegraphics-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="kde-4"

IUSE=""

RDEPEND="
	>=kde-base/gwenview-${PV}:${SLOT}
	>=kde-base/kamera-${PV}:${SLOT}
	>=kde-base/kcolorchooser-${PV}:${SLOT}
	>=kde-base/kgamma-${PV}:${SLOT}
	>=kde-base/kolourpaint-${PV}:${SLOT}
	>=kde-base/kruler-${PV}:${SLOT}
	>=kde-base/ksnapshot-${PV}:${SLOT}
	>=kde-base/libkscan-${PV}:${SLOT}
	>=kde-base/okular-${PV}:${SLOT}
	>=kde-base/svgpart-${PV}:${SLOT}
"
