# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.1-r1.ebuild,v 1.7 2003/03/08 14:36:29 weeve Exp $
inherit kde-dist flag-o-matic

IUSE=""
DESCRIPTION="KDE educational apps"
KEYWORDS="x86 ~ppc sparc ~alpha"

# patch to fix bug #51708 on bugs.kde.org, from kstars developer
# together with smaller fixes from the 3_1_BRANCH of kstars at this date
PATCHES="${FILESDIR}/${P}-branch-20030202.diff"

if [ "`gcc -dumpversion`" == "2.95.3" ]; then
	filter-flags "-fomit-frame-pointer"
fi
