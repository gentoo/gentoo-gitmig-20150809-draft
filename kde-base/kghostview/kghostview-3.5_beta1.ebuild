# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kghostview/kghostview-3.5_beta1.ebuild,v 1.2 2005/10/22 06:59:54 halcy0n Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Viewer for PostScript (.ps, .eps) and Portable Document Format (.pdf) files"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="${DEPEND}
	virtual/ghostscript"
KMEXTRA="kfile-plugins/ps"

