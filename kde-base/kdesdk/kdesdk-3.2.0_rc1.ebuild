# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.2.0_rc1.ebuild,v 1.1 2004/01/19 03:23:22 caleb Exp $
inherit kde-dist

IUSE=""
DESCRIPTION="KDE SDK: kbabel, ..."
KEYWORDS="~x86 ~sparc ~amd64"

DEPEND="!dev-util/umbrello
	!dev-util/kcachegrind
	>=dev-util/calltree-0.9.1
	media-gfx/graphviz
	sys-devel/flex"

RDEPEND="$DEPEND"
