# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpdf/kpdf-3.4.1-r2.ebuild,v 1.1 2005/12/08 02:24:09 carlo Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kpdf, a kde pdf viewer based on xpdf"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="nodrm"
KMEXTRA="kfile-plugins/pdf"

DEPEND=">=media-libs/freetype-2.0.5 media-libs/t1lib"

PATCHES="${FILESDIR}/post-3.4.1-kdegraphics-4.diff ${FILESDIR}/kpdf-3.4.3-CAN-2005-3193.patch"

src_compile() {
	myconf="${myconf} $(use_enable !nodrm kpdf-drm)"

	kde-meta_src_compile
}
