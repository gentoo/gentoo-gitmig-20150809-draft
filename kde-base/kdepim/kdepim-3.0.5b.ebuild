# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.0.5b.ebuild,v 1.3 2003/07/16 16:59:59 pvdabeel Exp $
inherit kde-dist

IUSE="pda"
DESCRIPTION="KDE $PV - PIM (Personal Information Management) apps: korganizer..."
KEYWORDS="x86 ppc ~alpha sparc"

newdepend "pda? ( >=dev-libs/pilot-link-0.11.1-r1 )
	dev-lang/perl"

use pda && myconf="$myconf --with-extra-includes=/usr/include/libpisock"

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}
