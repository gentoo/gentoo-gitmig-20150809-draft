# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-2.2.2.ebuild,v 1.10 2002/12/09 04:25:04 manson Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - artwork"

KEYWORDS="x86 sparc "

src_install() {
	dodir ${KDEDIR}/share/apps/kthememgr/Themes
	kde_src_install
}
