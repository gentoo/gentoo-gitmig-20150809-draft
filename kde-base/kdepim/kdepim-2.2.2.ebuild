# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-2.2.2.ebuild,v 1.4 2002/07/11 06:30:27 drobbins Exp $

inherit kde-dist || die

DESCRIPTION="${DESCRIPTION}PIM"

DEPEND="$DEPEND sys-devel/perl"

newdepend ">=dev-libs/pilot-link-0.9.0"

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}
