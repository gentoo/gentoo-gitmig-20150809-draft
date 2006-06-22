# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-kfile-plugins/kdegraphics-kfile-plugins-3.4.3.ebuild,v 1.10 2006/06/22 13:19:46 flameeyes Exp $

KMNAME=kdegraphics
KMMODULE=kfile-plugins
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kfile plugins from kdegraphics"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="tiff openexr"
DEPEND="tiff? ( media-libs/tiff )
	openexr? ( media-libs/openexr )"

# ps installed with kghostview, pdf installed with kpdf
KMEXTRACTONLY="kfile-plugins/ps kfile-plugins/pdf"

PATCHES="$FILESDIR/configure-fix-kdegraphics-openexr.patch"

src_compile() {
	myconf="$myconf $(use_with openexr)"
	kde-meta_src_compile
}
