# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.0.1.20020604.ebuild,v 1.1 2002/06/05 19:14:09 danarmak Exp $

inherit kde-patch kde-dist

DESCRIPTION="${DESCRIPTION}PIM"

DEPEND="$DEPEND sys-devel/perl"

newdepend "pda? ( >=dev-libs/pilot-link-0.9.0 )"

use pda && myconf="$myconf --with-extra-includes=/usr/include/libpisock"

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}
