# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kghostview/kghostview-3.5.2.ebuild,v 1.1 2006/03/22 20:15:19 danarmak Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Viewer for PostScript (.ps, .eps) and Portable Document Format (.pdf) files"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
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
