# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpovmodeler/kpovmodeler-3.4.0.ebuild,v 1.2 2005/03/18 17:54:49 morfic Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Modeler for POV-Ray Scenes"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND="virtual/opengl"
RDEPEND="${DEPEND}
	media-gfx/povray"
