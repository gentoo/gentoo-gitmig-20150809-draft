# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kghostview/kghostview-3.4.2.ebuild,v 1.2 2005/08/05 10:53:12 greg_g Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Viewer for PostScript (.ps, .eps) and Portable Document Format (.pdf) files"
KEYWORDS=" ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
RDEPEND="${DEPEND}
	virtual/ghostscript"
KMEXTRA="kfile-plugins/ps"

# Fix compilation with gcc4. Applied for 3.5.
PATCHES1="${FILESDIR}/kdegraphics-3.4-gcc4.patch"
