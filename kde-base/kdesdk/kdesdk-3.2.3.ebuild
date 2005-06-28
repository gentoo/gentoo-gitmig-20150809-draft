# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.2.3.ebuild,v 1.11 2005/06/28 19:25:28 caleb Exp $
inherit kde-dist

IUSE=""
DESCRIPTION="KDE SDK: Cervisia, KBabel, KCachegrind, Kompare, Umbrello,..."
KEYWORDS="x86 sparc amd64 ppc hppa"

DEPEND="media-gfx/graphviz
	sys-devel/flex"

RDEPEND="$DEPEND"
