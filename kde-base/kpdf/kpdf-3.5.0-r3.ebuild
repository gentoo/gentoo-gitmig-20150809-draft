# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpdf/kpdf-3.5.0-r3.ebuild,v 1.1 2005/12/20 17:42:35 carlo Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kpdf, a kde pdf viewer based on xpdf"
KEYWORDS="~alpha ~amd64 ~ppc64 ~sparc ~x86"
IUSE=""
KMEXTRA="kfile-plugins/pdf"

DEPEND=">=media-libs/freetype-2.0.5
	media-libs/t1lib
	>=app-text/poppler-0.3.1"

PATCHES="${FILESDIR}/post-3.5.0-kdegraphics-CAN-2005-3193.diff
	${FILESDIR}/kpdf-3.5.0-splitter-io.patch
	${FILESDIR}/kpdf-3.5.0-cropbox-fix.patch"

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
