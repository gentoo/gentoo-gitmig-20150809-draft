# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksvg/ksvg-3.5.10.ebuild,v 1.2 2009/04/30 12:00:35 tampakrap Exp $

KMNAME=kdegraphics
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="SVG viewer library and embeddable kpart"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-libs/freetype-2.3
	media-libs/fontconfig
	media-libs/libart_lgpl
	media-libs/lcms
	dev-libs/fribidi"
RDEPEND="${DEPEND}"

src_unpack() {
	kde-meta_src_unpack

	if has_version ">=dev-libs/fribidi-0.19.1"; then
		epatch "${FILESDIR}/${PN}-fribidi.patch"
		filter-ldflags -Wl, --as-needed
	fi
}
