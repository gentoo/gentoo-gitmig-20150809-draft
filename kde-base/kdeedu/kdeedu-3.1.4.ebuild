# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.1.4.ebuild,v 1.4 2003/10/04 22:39:18 brad_mssw Exp $
inherit kde-dist flag-o-matic

IUSE=""
DESCRIPTION="KDE educational apps"
KEYWORDS="x86 ~ppc sparc ~amd64"

if [ "`gcc -dumpversion`" == "2.95.3" ]; then
	filter-flags "-fomit-frame-pointer"
fi
