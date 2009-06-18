# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpdf/kpdf-3.5.10-r1.ebuild,v 1.3 2009/06/18 04:12:38 jer Exp $

KMNAME=kdegraphics
EAPI="1"
inherit kde-meta flag-o-matic

SRC_URI="${SRC_URI}
	mirror://gentoo/${P}-JBIG2.tar.bz2"

DESCRIPTION="kpdf, a kde pdf viewer based on xpdf"
KEYWORDS="~alpha amd64 hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""
KMEXTRA="kfile-plugins/pdf"

DEPEND=">=media-libs/freetype-2.3
	media-libs/t1lib
	>=virtual/poppler-qt3-0.6.1"
RDEPEND="${DEPEND}
	|| ( >=kde-base/kdeprint-${PV}:${SLOT} >=kde-base/kdebase-${PV}:${SLOT} )"

PATCHES=( "${FILESDIR}/kde-CVE-2009-1188.patch"
	"${WORKDIR}/${P}-JBIG2.patch"
	"${FILESDIR}/${P}-font-hiding.patch" )

src_compile() {
	local myconf="--with-poppler"
	replace-flags "-Os" "-O2" # see bug 114822

	# Fix the desktop file.
	sed -i -e "s:PDFViewer;:Viewer;:" "${S}/kpdf/shell/kpdf.desktop"

	kde-meta_src_compile
}
