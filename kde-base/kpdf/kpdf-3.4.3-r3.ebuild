# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpdf/kpdf-3.4.3-r3.ebuild,v 1.8 2005/12/29 11:13:13 greg_g Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kpdf, a kde pdf viewer based on xpdf"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="nodrm"
KMEXTRA="kfile-plugins/pdf"

DEPEND=">=media-libs/freetype-2.0.5
	media-libs/t1lib"
RDEPEND="${DEPEND}
	|| ( >=app-text/poppler-0.4.3-r1
	     <app-text/xpdf-3.01-r4 )" # kfile-plugins/pdf depends on "pdfinfo"

PATCHES="${FILESDIR}/post-3.4.3-kdegraphics-CAN-2005-3193.diff"

src_compile() {
	myconf="${myconf} $(use_enable !nodrm kpdf-drm)"

	kde-meta_src_compile
}
