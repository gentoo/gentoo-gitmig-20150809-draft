# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkexiv2/libkexiv2-4.8.3.ebuild,v 1.1 2012/05/03 20:08:05 johu Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE Image Plugin Interface: an exiv2 library wrapper"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=media-gfx/exiv2-0.20
	media-libs/lcms:0
	virtual/jpeg
"
RDEPEND="${DEPEND}"
