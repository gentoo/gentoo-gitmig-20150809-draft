# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.2.0.ebuild,v 1.2 2004/02/05 16:44:24 lu_zero Exp $
inherit kde-dist

IUSE=""
DESCRIPTION="KDE SDK: kbabel, ..."
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"

DEPEND="!dev-util/umbrello
	!dev-util/kcachegrind
	x86? ( >=dev-util/calltree-0.9.1 )
	media-gfx/graphviz
	sys-devel/flex"

RDEPEND="$DEPEND"
