# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.1.3.ebuild,v 1.4 2003/09/08 01:59:57 caleb Exp $
inherit kde-dist flag-o-matic

IUSE=""
DESCRIPTION="KDE educational apps"
KEYWORDS="x86 ~ppc ~sparc"

if [ "`gcc -dumpversion`" == "2.95.3" ]; then
	filter-flags "-fomit-frame-pointer"
fi
