# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.0.1.ebuild,v 1.1 2002/05/13 19:42:32 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist

DESCRIPTION="${DESCRIPTION}PIM"

DEPEND="$DEPEND sys-devel/perl"

newdepend "pda? ( >=dev-libs/pilot-link-0.9.0 )"

use pda && myconf="$myconf --with-extra-includes=/usr/include/libpisock"

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}
