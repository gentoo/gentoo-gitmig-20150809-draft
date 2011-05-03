# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf/xpdf-9999.ebuild,v 1.2 2011/05/03 11:29:42 scarabeus Exp $

EAPI=4

EGIT_REPO_URI="https://github.com/rbrito/xpdf-poppler.git"
inherit autotools autotools-utils git-2

DESCRIPTION="An X Viewer for PDF Files - Poppler fork"
HOMEPAGE="https://github.com/rbrito/xpdf-poppler"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	app-text/poppler[xpdf-headers]
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXpm
	x11-libs/openmotif
"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	autotools-utils_src_prepare
}
