# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.2.0_beta1-r1.ebuild,v 1.2 2003/11/06 18:39:25 caleb Exp $
inherit kde-dist

IUSE=""
DESCRIPTION="KDE SDK: kbabel, ..."
KEYWORDS="~x86"

newdepend "!dev-util/umbrello
	!dev-util/kcachegrind
	>=dev-util/calltree-0.9.1
	media-gfx/graphviz
	sys-devel/flex"
