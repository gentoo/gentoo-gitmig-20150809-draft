# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.1.3.ebuild,v 1.4 2003/08/13 12:23:19 weeve Exp $
inherit kde-dist 

IUSE=""
DESCRIPTION="KDE utilities"

#RDEPEND="$RDEPEND app-admin/dosfstools" # for kfloppy
KEYWORDS="~x86 ~ppc ~sparc"

src_unpack()
{
	kde_src_unpack
	epatch ${FILESDIR}/${P}-gcc33.diff
}
