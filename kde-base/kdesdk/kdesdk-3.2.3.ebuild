# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.2.3.ebuild,v 1.8 2004/09/29 19:43:13 carlo Exp $
inherit kde-dist

IUSE=""
DESCRIPTION="KDE SDK: Cervisia, KBabel, KCachegrind, Kompare, Umbrello,..."
KEYWORDS="x86 sparc amd64 ppc hppa"

DEPEND="!dev-util/umbrello
	!dev-util/kcachegrind
	x86? ( >=dev-util/calltree-0.9.1 )
	media-gfx/graphviz
	sys-devel/flex"

RDEPEND="$DEPEND"
