# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkexiv2/libkexiv2-4.8.5.ebuild,v 1.5 2012/10/13 22:33:21 johu Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE Image Plugin Interface: an exiv2 library wrapper"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=media-gfx/exiv2-0.20
	media-libs/lcms:0
	virtual/jpeg
"
RDEPEND="${DEPEND}"
