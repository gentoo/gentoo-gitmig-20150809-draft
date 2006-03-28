# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpovmodeler/kpovmodeler-3.5.0-r1.ebuild,v 1.3 2006/03/28 04:56:59 agriffis Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Modeler for POV-Ray Scenes"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="virtual/opengl
	>=media-libs/freetype-2"
RDEPEND="${DEPEND}
	media-gfx/povray"

# Fix saving in kpovmodeler (kde bug 116895). Applied for 3.5.1.
PATCHES="${FILESDIR}/kdegraphics-3.5.0-kpovmodeler.patch"
