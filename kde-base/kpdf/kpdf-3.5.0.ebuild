# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpdf/kpdf-3.5.0.ebuild,v 1.6 2006/03/24 12:31:25 agriffis Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kpdf, a kde pdf viewer based on xpdf"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""
KMEXTRA="kfile-plugins/pdf"

DEPEND=">=media-libs/freetype-2.0.5
	media-libs/t1lib
	>=app-text/poppler-0.3.1"

pkg_setup() {
	if ! built_with_use app-text/poppler qt; then
		eerror "This package requires app-text/poppler compiled with Qt support."
		eerror "Please reemerge app-text/poppler with USE=\"qt\"."
		die "Please reemerge app-text/poppler with USE=\"qt\"."
	fi
}

src_compile() {
	local myconf="--with-poppler"

	kde-meta_src_compile
}
