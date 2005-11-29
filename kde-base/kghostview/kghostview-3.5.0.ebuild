# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kghostview/kghostview-3.5.0.ebuild,v 1.3 2005/11/29 14:08:45 greg_g Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Viewer for PostScript (.ps, .eps) and Portable Document Format (.pdf) files"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""
RDEPEND="${DEPEND}
	virtual/ghostscript"
KMEXTRA="kfile-plugins/ps"

pkg_setup() {
	if ! built_with_use virtual/ghostscript X; then
		eerror "This package requires virtual/ghostscript compiled with X11 support."
		eerror "Please reemerge virtual/ghostscript with USE=\"X\"."
		die "Please reemerge virtual/ghostscript with USE=\"X\"."
	fi
}
