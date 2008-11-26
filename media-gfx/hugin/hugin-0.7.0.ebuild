# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/hugin/hugin-0.7.0.ebuild,v 1.3 2008/11/26 21:08:36 dirtyepic Exp $

EAPI="1"
WX_GTK_VER="2.8"

inherit cmake-utils eutils wxwidgets

DESCRIPTION="GUI for the creation & processing of panoramic images"
HOMEPAGE="http://hugin.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2 SIFT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+sift"

DEPEND="
	app-arch/zip
	>=dev-libs/boost-1.30.0
	>=media-gfx/enblend-3.0_p20080807
	media-libs/jpeg
	media-libs/libpano13
	media-libs/libpng
	media-libs/openexr
	media-libs/tiff
	sys-libs/zlib
	x11-libs/wxGTK:2.8
	sift? ( media-gfx/autopano-sift-C )"

S="${WORKDIR}/${PN}-0.7.0"
DOCS="AUTHORS README TODO"

pkg_setup() {
	if ! built_with_use --missing true dev-libs/boost threads ; then
		local msg="Build dev-libs/boost with USE=threads"
		eerror "$msg"
		die "$msg"
	fi
	wxwidgets_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.7.0_rc2-as-needed.patch
}
