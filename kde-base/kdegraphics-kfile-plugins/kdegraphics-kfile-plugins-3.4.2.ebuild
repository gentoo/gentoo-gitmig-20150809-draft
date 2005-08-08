# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-kfile-plugins/kdegraphics-kfile-plugins-3.4.2.ebuild,v 1.2 2005/08/08 20:27:59 kloeri Exp $

KMNAME=kdegraphics
KMMODULE=kfile-plugins
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kfile plugins from kdegraphics"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="tiff openexr"
DEPEND="tiff? ( media-libs/tiff )
	openexr? ( media-libs/openexr )"
RDEPEND="${DEPEND}
	app-text/xpdf" # needed for "pdfinfo"

# ps installed with kghostview, pdf installed with kpdf
KMEXTRACTONLY="kfile-plugins/ps kfile-plugins/pdf"

PATCHES="$FILESDIR/configure-fix-kdegraphics-openexr.patch"
myconf="$myconf $(use_with openexr)"
