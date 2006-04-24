# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kghostview/kghostview-3.5.2.ebuild,v 1.5 2006/04/24 19:15:56 flameeyes Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Viewer for PostScript (.ps, .eps) and Portable Document Format (.pdf) files"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
# /Should/ also rdepend on kdeprint. Since kdeprint rdepends on kghostview for previews, we'd had a conflict, so we can't.
RDEPEND="virtual/ghostscript"
KMEXTRA="kfile-plugins/ps"

pkg_setup() {
	for ghostscript in app-text/ghostscript-{gnu,esp,afpl}; do
		if has_version ${ghostscript} && !built_with_use ${ghostscript} X; then
			eerror "This package requires ${ghostscript} compiled with X11 support."
			eerror "Please reemerge ${ghostscript} with USE=\"X\"."
			die "Please reemerge ${ghostscript} with USE=\"X\"."
		fi
	done
}
