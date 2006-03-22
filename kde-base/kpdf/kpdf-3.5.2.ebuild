# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpdf/kpdf-3.5.2.ebuild,v 1.1 2006/03/22 20:15:36 danarmak Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta flag-o-matic

DESCRIPTION="kpdf, a kde pdf viewer based on xpdf"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
KMEXTRA="kfile-plugins/pdf"

DEPEND=">=media-libs/freetype-2.0.5
	media-libs/t1lib
	>=app-text/poppler-0.5.0-r1
	>=app-text/poppler-bindings-0.5.0"

#SRC_URI="${SRC_URI}
#	mirror://gentoo/${PN}-3.5.1-poppler-2.patch.bz2
#	mirror://gentoo/kpdf-3.5.1-poppler-0.5.1-bis.patch.bz2"

#PATCHES="${DISTDIR}/${PN}-3.5.1-poppler-2.patch.bz2"

pkg_setup() {
	if ! built_with_use app-text/poppler-bindings qt; then
		eerror "This package requires app-text/poppler-bindings compiled with Qt support."
		eerror "Please reemerge app-text/poppler-bindings with USE=\"qt\"."
		die "Please reemerge app-text/poppler-bindings with USE=\"qt\"."
	fi
}

src_unpack() {
	kde-meta_src_unpack

	# Lovely when libraries changes API in micro releases.
#	has_version ">=app-text/poppler-0.5.1" && \
#		epatch "${DISTDIR}/kpdf-3.5.1-poppler-0.5.1-bis.patch.bz2"
}

src_compile() {
	local myconf="--with-poppler"
	replace-flags "-Os" "-O2" # see bug 114822
	kde-meta_src_compile
}
