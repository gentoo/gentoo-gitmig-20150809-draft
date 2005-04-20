# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-3.3.2-r1.ebuild,v 1.3 2005/04/20 13:03:20 weeve Exp $

inherit kde-dist eutils

DESCRIPTION="KDE web development - Quanta"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ppc64 sparc x86 ~mips"
IUSE="doc"

DEPEND="~kde-base/kdebase-${PV}
	doc? ( app-doc/quanta-docs )"

src_unpack(){
	kde_src_unpack
	epatch ${FILESDIR}/post-3.4-kdewebdev.diff
}