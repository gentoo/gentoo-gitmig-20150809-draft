# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/gwenview/gwenview-4.0.0.ebuild,v 1.2 2008/01/18 22:23:28 ingmar Exp $

EAPI="1"

KMNAME=kdegraphics
inherit kde4-meta

DESCRIPTION="KDE image viewer"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="
	media-gfx/exiv2
	media-libs/jpeg"
RDEPEND="${DEPEND}"

src_unpack() {
	if use htmlhandbook; then
		PATCHES="${FILESDIR}"/${P}-htmlhandbook.patch
	fi
	kde4-meta_src_unpack
}
