# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.1_beta1.ebuild,v 1.2 2002/08/30 07:05:24 danarmak Exp $
inherit kde-dist 

DESCRIPTION="KDE $PV - PIM (Personal Information Management) apps: korganizer..."
KEYWORDS="x86"
DEPEND="$DEPEND sys-devel/perl"

newdepend "pda? ( >=dev-libs/pilot-link-0.11.1-r1 )
	    ~kde-base/kdebase-$PV"

use pda && myconf="$myconf --with-extra-includes=/usr/include/libpisock"

PATCHES="$FILESDIR/$P-cerr.diff"

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}
