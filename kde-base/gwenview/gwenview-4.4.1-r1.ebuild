# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/gwenview/gwenview-4.4.1-r1.ebuild,v 1.3 2010/04/29 03:56:32 reavertm Exp $

EAPI="3"

KMNAME="kdegraphics"
inherit eutils kde4-meta

DESCRIPTION="KDE image viewer"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook kipi semantic-desktop"

SRC_URI="${SRC_URI}
	mirror://gentoo/${P}-libjpeg-8a.patch.bz2"

# tests hang, last checked for 4.2.96
RESTRICT="test"

DEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop?')
	>=media-gfx/exiv2-0.18
	>=media-libs/jpeg-8a
	kipi? ( $(add_kdebase_dep libkipi) )
"
RDEPEND="${DEPEND}"

src_unpack() {
	kde4-meta_src_unpack
	unpack ${P}-libjpeg-8a.patch.bz2
}

src_prepare() {
	kde4-meta_src_prepare
	epatch "${WORKDIR}"/${P}-libjpeg-8a.patch
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with kipi)
	)

	if use semantic-desktop; then
		mycmakeargs+=(-DGWENVIEW_SEMANTICINFO_BACKEND=Nepomuk)
	else
		mycmakeargs+=(-DGWENVIEW_SEMANTICINFO_BACKEND=None)
	fi

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	echo
	elog "For SVG support, emerge -va kde-base/svgpart"
	echo
}
