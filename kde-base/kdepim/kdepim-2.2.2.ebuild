# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-2.2.2.ebuild,v 1.5 2002/07/25 17:53:21 danarmak Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - PIM (Personal Information Management) apps: korganizer..."
KEYWORDS="x86"

DEPEND="$DEPEND sys-devel/perl"

newdepend ">=dev-libs/pilot-link-0.9.0"

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}
