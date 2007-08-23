# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpdf/kpdf-3.5.7-r2.ebuild,v 1.1 2007/08/23 15:14:39 philantrop Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta flag-o-matic

DESCRIPTION="kpdf, a kde pdf viewer based on xpdf"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
KMEXTRA="kfile-plugins/pdf"

DEPEND=">=media-libs/freetype-2.0.5
	media-libs/t1lib
	>=app-text/poppler-0.5.1
	>=app-text/poppler-bindings-0.5.1"
RDEPEND="${DEPEND}
	$(deprange-dual $PV $MAXKDEVER kde-base/kdeprint)"

PATCHES="${FILESDIR}/post-3.5.7-kdegraphics-CVE-2007-3387.diff
		${FILESDIR}/${P}-hash_path.diff"

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
