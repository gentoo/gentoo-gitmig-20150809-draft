# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.4.1-r1.ebuild,v 1.6 2005/10/18 21:53:46 agriffis Exp $

inherit kde-dist

DESCRIPTION="KDE educational apps"

KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc x86"
IUSE=""

DEPEND=""

PATCHES="${FILESDIR}/post-3.4.2-kdeedu.diff"

myconf="--disable-kig-python-scripting"
