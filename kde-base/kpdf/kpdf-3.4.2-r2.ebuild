# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpdf/kpdf-3.4.2-r2.ebuild,v 1.2 2005/08/08 20:26:25 kloeri Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kpdf, a kde pdf viewer based on xpdf"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="nodrm"
KMEXTRA="kfile-plugins/pdf"

DEPEND=">=media-libs/freetype-2.0.5 media-libs/t1lib"

# Fix regression in kpdf (kde bug 110000). Applied for 3.4.3.
# Fix crash in kpdf (kde bug 110111). Applied for 3.4.3.
PATCHES1="${FILESDIR}/kdegraphics-3.4.2-kpdf-fix.patch
	${FILESDIR}/kdegraphics-3.4.2-kpdf-contentcrash.patch"

src_compile() {
	myconf="${myconf} $(use_enable !nodrm kpdf-drm)"

	kde-meta_src_compile
}
