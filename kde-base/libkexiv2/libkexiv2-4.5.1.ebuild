# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkexiv2/libkexiv2-4.5.1.ebuild,v 1.1 2010/09/06 01:41:13 tampakrap Exp $

EAPI="3"

KMNAME="kdegraphics"
KMMODULE="libs/libkexiv2"
inherit kde4-meta

DESCRIPTION="KDE Image Plugin Interface: an exiv2 library wrapper"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=media-gfx/exiv2-0.18
	media-libs/jpeg
	media-libs/lcms:0
"
RDEPEND="${DEPEND}"
