# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-2.2.2.ebuild,v 1.13 2003/07/16 16:18:11 pvdabeel Exp $
inherit kde-dist

IUSE=""
DESCRIPTION="KDE $PV - artwork"
KEYWORDS="x86 sparc ppc"

src_install() {
	dodir ${KDEDIR}/share/apps/kthememgr/Themes
	kde_src_install
}
