# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.2.2.ebuild,v 1.7 2005/01/12 18:44:13 gustavoz Exp $
inherit kde-dist

IUSE=""
DESCRIPTION="KDE SDK: kbabel, ..."
KEYWORDS="x86 sparc amd64 ppc"

DEPEND="!dev-util/umbrello
	!dev-util/kcachegrind
	x86? ( >=dev-util/calltree-0.9.1 )
	media-gfx/graphviz
	sys-devel/flex"

RDEPEND="$DEPEND"
