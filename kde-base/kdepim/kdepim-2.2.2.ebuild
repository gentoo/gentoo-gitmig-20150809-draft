# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-2.2.2.ebuild,v 1.8 2002/10/04 05:43:00 vapier Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - PIM (Personal Information Management) apps: korganizer..."
KEYWORDS="x86 sparc sparc64"

DEPEND="$DEPEND sys-devel/perl"

newdepend ">=dev-libs/pilot-link-0.9.0"

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}
