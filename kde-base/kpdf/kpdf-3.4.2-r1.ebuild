# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpdf/kpdf-3.4.2-r1.ebuild,v 1.1 2005/08/05 10:51:56 greg_g Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kpdf, a kde pdf viewer based on xpdf"
KEYWORDS=" ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="nodrm"
KMEXTRA="kfile-plugins/pdf"

DEPEND=">=media-libs/freetype-2.0.5 media-libs/t1lib"

# Fix regression in kpdf (kde bug 110000). Applied for 3.4.3.
PATCHES1="${FILESDIR}/kdegraphics-3.4.2-kpdf-fix.patch"

src_compile() {
	myconf="${myconf} $(use_enable !nodrm kpdf-drm)"

	kde-meta_src_compile
}
