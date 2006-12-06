# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpdf/kpdf-3.5.5.ebuild,v 1.7 2006/12/06 13:59:28 kloeri Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta flag-o-matic

DESCRIPTION="kpdf, a kde pdf viewer based on xpdf"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
KMEXTRA="kfile-plugins/pdf"

DEPEND=">=media-libs/freetype-2.0.5
	media-libs/t1lib
	>=app-text/poppler-0.5.1
	>=app-text/poppler-bindings-0.5.1"
RDEPEND="${DEPEND}
	$(deprange-dual $PV $MAXKDEVER kde-base/kdeprint)"

SRC_URI="${SRC_URI}
	mirror://gentoo/${PN}-3.5.3-poppler-bis.patch.bz2"

PATCHES="${DISTDIR}/${PN}-3.5.3-poppler-bis.patch.bz2"

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
	kde-meta_src_compile
}
