# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.0.4.ebuild,v 1.7 2003/08/30 10:19:25 liquidx Exp $
inherit kde-dist

IUSE="pda"
DESCRIPTION="KDE $PV - PIM (Personal Information Management) apps: korganizer..."
KEYWORDS="x86 ppc alpha"

newdepend "pda? ( >=app-pda/pilot-link-0.11.1-r1 )
	dev-lang/perl"

use pda && myconf="$myconf --with-extra-includes=/usr/include/libpisock"

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}
