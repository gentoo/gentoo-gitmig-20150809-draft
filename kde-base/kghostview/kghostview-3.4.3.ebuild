# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kghostview/kghostview-3.4.3.ebuild,v 1.5 2005/11/25 01:18:04 cryos Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Viewer for PostScript (.ps, .eps) and Portable Document Format (.pdf) files"
KEYWORDS="~alpha amd64 ~ppc ppc64 sparc ~x86"
IUSE=""

RDEPEND="${DEPEND}
	virtual/ghostscript"

KMEXTRA="kfile-plugins/ps"
