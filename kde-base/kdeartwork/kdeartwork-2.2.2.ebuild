# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-2.2.2.ebuild,v 1.5 2002/07/11 06:30:26 drobbins Exp $

inherit kde-dist || die

DESCRIPTION="${DESCRIPTION}Artwork"

src_install() {
	dodir ${KDEDIR}/share/apps/kthememgr/Themes
	kde_src_install
}
