# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-2.2.2.ebuild,v 1.2 2001/12/23 21:35:15 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist || die

DESCRIPTION="${DESCRIPTION}PIM"

DEPEND="$DEPEND sys-devel/perl"

newdepend ">=dev-libs/pilot-link-0.9.0"

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}
