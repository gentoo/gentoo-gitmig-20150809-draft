# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.4.1-r1.ebuild,v 1.1 2005/08/14 23:33:39 carlo Exp $

inherit kde-dist

DESCRIPTION="KDE educational apps"

KEYWORDS="~amd64 ~ia64 ~mips ~ppc ~sparc x86 ~hppa"
IUSE=""

DEPEND=""

PATCHES="${FILESDIR}/post-3.4.2-kdeedu.diff"

myconf="--disable-kig-python-scripting"
