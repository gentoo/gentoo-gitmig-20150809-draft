# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.2.0_beta2.ebuild,v 1.2 2003/12/28 03:48:19 caleb Exp $
inherit kde-dist

IUSE=""
DESCRIPTION="KDE SDK: kbabel, ..."
KEYWORDS="~x86"

DEPEND="!dev-util/umbrello
	!dev-util/kcachegrind
	>=dev-util/calltree-0.9.1
	media-gfx/graphviz
	sys-devel/flex"

RDEPEND="$DEPEND"
