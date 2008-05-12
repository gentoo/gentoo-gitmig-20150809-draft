# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpdf/kpdf-3.5.9.ebuild,v 1.5 2008/05/12 20:02:23 ranger Exp $

KMNAME=kdegraphics
EAPI="1"
inherit kde-meta flag-o-matic

DESCRIPTION="kpdf, a kde pdf viewer based on xpdf"
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""
KMEXTRA="kfile-plugins/pdf"

DEPEND=">=media-libs/freetype-2.3
	media-libs/t1lib
	>=app-text/poppler-0.6.1
	>=app-text/poppler-bindings-0.6.1"
RDEPEND="${DEPEND}
	|| ( >=kde-base/kdeprint-${PV}:${SLOT} >=kde-base/kdebase-${PV}:${SLOT} )"

pkg_setup() {
	kde_pkg_setup
	# check for qt still until it had a revision bump in both ~arch and stable.
	if ! built_with_use app-text/poppler-bindings qt3; then
		eerror "This package requires app-text/poppler-bindings compiled with Qt 3.x support."
		eerror "Please reemerge app-text/poppler-bindings with USE=\"qt3\"."
		die "Please reemerge app-text/poppler-bindings with USE=\"qt3\"."
	fi
}

src_compile() {
	local myconf="--with-poppler"
	replace-flags "-Os" "-O2" # see bug 114822

	# Fix the desktop file.
	sed -i -e "s:PDFViewer;:Viewer;:" "${S}/kpdf/shell/kpdf.desktop"

	kde-meta_src_compile
}
