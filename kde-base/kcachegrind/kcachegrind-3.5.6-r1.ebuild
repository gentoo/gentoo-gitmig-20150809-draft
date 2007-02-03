# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcachegrind/kcachegrind-3.5.6-r1.ebuild,v 1.1 2007/02/03 23:57:06 flameeyes Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE Frontend for Cachegrind"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND="x86? ( >=dev-util/valgrind-3.2.0 )
	amd64?	( >=dev-util/valgrind-3.2.0 )"

RDEPEND="${DEPEND}
	media-gfx/graphviz"

PATCHES="${FILESDIR}/${P}-graphviz-fix.patch"
