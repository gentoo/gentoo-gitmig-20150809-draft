# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.1.5.ebuild,v 1.8 2004/08/30 15:45:01 pvdabeel Exp $
inherit kde-dist flag-o-matic

IUSE=""
DESCRIPTION="KDE educational apps"
KEYWORDS="x86 ppc sparc hppa amd64 alpha ia64"

src_compile() {

if [ "`gcc -dumpversion`" == "2.95.3" ]; then
	filter-flags "-fomit-frame-pointer"
fi
	kde_src_compile
}
